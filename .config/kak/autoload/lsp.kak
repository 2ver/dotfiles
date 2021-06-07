plug "kak-lsp/kak-lsp" do %{
   cargo install --locked --force --path .
} config %{
   # Check that kak-lsp binary is available in path
   # try %{
   #    evaluate-commands %sh{
   #       is command -v kak-lsp >/dev/null; then
   #          echo 'nop'
   #       else
   #          echo 'echo -debug "kak-lsp binary missing"'
   #          echo 'echo -debug "run `doas pacman -S kak-lsp`"'
   #          echo 'fail'
   #       fi
   #    }

      # Run kak-lsp (if not using plug)
      # eval %sh{
      #    kak-lsp --config $kak_config/lsp.toml --kakoune -s $kak_session
      # }

      # Enable lsp on specific windows
      hook global WinSetOption filetype=(c|haskell|latex|python|rust|yaml) %{
         lsp-enable-window
         echo -debug "Enabling LSP for filetype %opt{filetype}"
         set global lsp_hover_max_lines 10

         ## UI
         set global lsp_diagnostic_line_error_sign '║'      # Warning symbol next to line numbers
         set global lsp_diagnostic_line_warning_sign '┊'    # Error symbol next to line numbers
         face global DiagnosticWarning rgb:dee681           # Warning symbol color next to line numbers
         face global DiagnosticError rgb:e084a3             # Error symbol color next to line numbers
         face buffer InlayDiagnosticWarning rgba:dee68165+i # Inline warning color
         face buffer InlayDiagnosticError rgba:e084a385+i   # Inline error color
         lsp-diagnostic-lines-disable window                # Don't show symbols next to line numbers
         lsp-inlay-diagnostics-enable window                # Enable inline warnings/errors

         # Only show inline diagnostics in normal mode
         hook window NormalIdle .* %{
            rmhl window/lsp_diagnostics
            lsp-inlay-diagnostics-enable window
         }

         # Disable inline diagnostics in insert mode
         hook window ModeChange push:normal:insert %{
               lsp-inlay-diagnostics-disable window
         }
         
         ## Mappings
         map window user '<;>' ': lsp-hover<ret>' -docstring 'hover'
         map window user <:> ': lsp-code-actions<ret>' -docstring 'code actions'
         map window user <I> ': lsp-implementation<ret>' -docstring 'goto implementation'
         # unmap window <c-i>
         map window normal <tab> ': lsp-find-error<ret>' -docstring 'goto next error' # Ambiguous key (maps to <c-i>)
         map window normal <c-e> ': lsp-find-error --previous<ret>' -docstring 'goto last error'
         map window user <r> ': lsp-rename-prompt<ret>' -docstring 'rename'

      }

      # Semantic highlighting
      hook global WinSetOption filetype=(c|rust) %{
         hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
         hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
         hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
         hook -once -always window WinSetOption filetype=.* %{
            remove-hooks window semantic-tokens
         }
      }

      # Inlay hints
      hook global WinSetOption filetype=rust %{
         hook window -group rust-inlay-hints BufReload .* rust-analyzer-inlay-hints
         hook window -group rust-inlay-hints NormalIdle .* rust-analyzer-inlay-hints
         hook window -group rust-inlay-hints InsertIdle .* rust-analyzer-inlay-hints
         hook -once -always window WinSetOption filetype=.* %{
            remove-hooks window rust-inlay-hints
         }
      }

      # Commands
      define-command lsp-restart -docstring 'restart lsp server' %{
         lsp-exit
         lsp-start
      }

      # Python does not support kak-lsp.toml
      set-option global lsp_server_configuration pyls.configurationSources=["flake8"]

   # } catch %{
   #    echo -debug 'failed to initialize kak-lsp'
   # }
}
