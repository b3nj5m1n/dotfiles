; (module highlight)
; --- Highlight related stuff ---

(defn create-hl-groups [groups]
  (each [group config (pairs groups)]
    (vim.api.nvim_set_hl 0 group config)))

(vim.cmd "augroup highlight_yank
           autocmd!
           au TextYankPost * silent! lua vim.highlight.on_yank({higroup=\"IncSearch\", timeout=200})
           augroup END")

(defn create-groups-cursor-line [mode]
  (let [accent-a (if (= mode "normal") "#a6da95" (= mode "insert") "#ee99a0" "#8bd5ca")]
    (create-hl-groups
      {:CursorLineNr {:fg accent-a}})))

(defn create-groups-cursorword []
  (create-hl-groups
    {:MiniCursorword {:bg "#1e2030"}}
    {:MiniCursorwordCurrent {:bg "#181926"}}))

(defn create-groups-ufo []
  (let [accent "#342f50"]
    (create-hl-groups
      {:UfoFoldedFg {:fg accent}
       :UfoFoldedBg {:bg accent}
       :Folded {:bg accent}})))

(defn create-groups-telescope [mode]
  (let [bg "#181926"
        fg "#cad3f5"
        bg-light "#1e2030"
        accent-a (if (= mode "normal") "#a6da95" (= mode "insert") "#ee99a0" "#8bd5ca")
        accent-b "#c6a0f6"]
    (create-hl-groups
      {:TelescopeBorder {:bg bg :fg fg}
       :TelescopeNormal {:bg bg}
       :TelescopePreviewBorder {:bg bg :fg bg}
       :TelescopePreviewNormal {:bg bg}
       :TelescopePreviewTitle {:bg accent-b :fg bg}
       :TelescopePromptBorder {:bg bg-light :fg bg-light}
       :TelescopePromptNormal {:bg bg-light :fg fg}
       :TelescopePromptPrefix {:bg bg-light :fg accent-a}
       :TelescopePromptTitle {:bg accent-a :fg bg}
       :TelescopeResultsBorder {:bg bg :fg bg}
       :TelescopeResultsNormal {:bg bg}
       :TelescopeResultsTitle {:bg bg :fg bg}})))

(defn create-groups-cmp []
  (create-hl-groups
    {:PmenuSel {:bg "#282C34" :fg :NONE}
     :Pmenu {:fg "#C5CDD9" :bg "#22252A"}
     :CmpItemAbbrDeprecated {:fg "#7E8294" :bg :NONE :strikethrough true}
     :CmpItemAbbrMatch {:fg "#82AAFF" :bg :NONE :bold true}
     :CmpItemAbbrMatchFuzzy {:fg "#82AAFF" :bg :NONE :bold true}
     :CmpItemMenu {:fg "#C792EA" :bg :NONE :italic true}
     :CmpItemKindField {:fg "#EED8DA" :bg "#B5585F"}
     :CmpItemKindProperty {:fg "#EED8DA" :bg "#B5585F"}
     :CmpItemKindEvent {:fg "#EED8DA" :bg "#B5585F"}
     :CmpItemKindText {:fg "#C3E88D" :bg "#9FBD73"}
     :CmpItemKindEnum {:fg "#C3E88D" :bg "#9FBD73"}
     :CmpItemKindKeyword {:fg "#C3E88D" :bg "#9FBD73"}
     :CmpItemKindConstant {:fg "#FFE082" :bg "#D4BB6C"}
     :CmpItemKindConstructor {:fg "#FFE082" :bg "#D4BB6C"}
     :CmpItemKindReference {:fg "#FFE082" :bg "#D4BB6C"}
     :CmpItemKindFunction {:fg "#EADFF0" :bg "#A377BF"}
     :CmpItemKindStruct {:fg "#EADFF0" :bg "#A377BF"}
     :CmpItemKindClass {:fg "#EADFF0" :bg "#A377BF"}
     :CmpItemKindModule {:fg "#EADFF0" :bg "#A377BF"}
     :CmpItemKindOperator {:fg "#EADFF0" :bg "#A377BF"}
     :CmpItemKindVariable {:fg "#C5CDD9" :bg "#7E8294"}
     :CmpItemKindFile {:fg "#C5CDD9" :bg "#7E8294"}
     :CmpItemKindUnit {:fg "#F5EBD9" :bg "#D4A959"}
     :CmpItemKindSnippet {:fg "#F5EBD9" :bg "#D4A959"}
     :CmpItemKindFolder {:fg "#F5EBD9" :bg "#D4A959"}
     :CmpItemKindMethod {:fg "#DDE5F5" :bg "#6C8ED4"}
     :CmpItemKindValue {:fg "#DDE5F5" :bg "#6C8ED4"}
     :CmpItemKindEnumMember {:fg "#DDE5F5" :bg "#6C8ED4"}
     :CmpItemKindInterface {:fg "#D8EEEB" :bg "#58B5A8"}
     :CmpItemKindColor {:fg "#D8EEEB" :bg "#58B5A8"}
     :CmpItemKindTypeParameter {:fg "#D8EEEB" :bg "#58B5A8"}}))

