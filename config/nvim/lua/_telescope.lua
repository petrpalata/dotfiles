require('telescope').setup {
    defaults = {
        layout_strategy = "vertical",
        file_ignore_patterns = { "node_modules", "dist", ".env" }
    }
}
