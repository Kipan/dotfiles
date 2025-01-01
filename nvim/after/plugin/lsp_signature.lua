require "lsp_signature".setup(cfg)
require "lsp_signature".on_attach({
	bind = true,
	handler_opts = {
		border = "rounded"
	}
}, bufnr)
