return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  version = "1.*",
  opts = {
    open_cmd = "zen-browser %s --class typst-preview",
    dependencies_bin = {
      ["tinymist"] = "tinymist",
    },
  },
}
