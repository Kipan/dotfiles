require "lsp_signature".setup(cfg)
require "lsp_signature".on_attach({
    experimental = { ghost_text = true },
	bind = true,
	handler_opts = {
		border = "rounded"
	}
}, bufnr)
