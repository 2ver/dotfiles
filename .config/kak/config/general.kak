# Functionality
# ─────────────

# Save after lost focus
hook global FocusOut .* %{
   write-all
} -group kakrc-save-on-lost-focus
