-- Matches VS Code's mechatroner.rainbow-csv
return {
  "cameron-wags/rainbow_csv.nvim",
  ft = { "csv", "tsv", "csv_semicolon", "csv_whitespace", "csv_pipe" },
  cmd = { "RainbowDelim", "RainbowDelimSimple", "RainbowDelimQuoted", "RainbowAlign" },
}
