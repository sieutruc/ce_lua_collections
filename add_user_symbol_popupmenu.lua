local mf = getMemoryViewForm().DisassemblerView.PopupMenu
local addSymbolItem = createMenuItem(mf.Items)
addSymbolItem.Caption = 'Add user symbol'
mf.Items.add(addSymbolItem)
addSymbolItem.OnClick = function()
--[[
    Place GUI elements
  ]]
	MyForm = createForm(true)
	MyForm.caption = [[Add new symbol]]
	MyForm.width = 331
	MyForm.height = 49
	MyForm.align = alNone
	MyForm.enabled = nil
	MyForm.visible = true
	MyForm.Position = poScreenCenter
	-- Creating the objects
	CELabel1 = createLabel(MyForm)
	CELabel1.caption = [[Symbol Name:]]
	CELabel1.left = [[2]]
	CELabel1.top = [[3]]
	CELabel1.width = [[78]]
	CELabel1.height = [[15]]
	CELabel1.align = [[alNone]]
	CELabel1.enabled = [[true]]
	CELabel1.visible = [[true]]
	UserSymbolCEEdit = createEdit(MyForm)
	UserSymbolCEEdit.left = [[87]]
	UserSymbolCEEdit.top = [[2]]
	UserSymbolCEEdit.width = [[164]]
	UserSymbolCEEdit.height = [[23]]
	UserSymbolCEEdit.align = [[alNone]]
	UserSymbolCEEdit.enabled = [[true]]
	UserSymbolCEEdit.visible = [[true]]
	CELabel2 = createLabel(MyForm)
	CELabel2.caption = [[at ...]]
	CELabel2.left = [[10]]
	CELabel2.top = [[30]]
	CELabel2.width = [[48]]
	CELabel2.height = [[15]]
	CELabel2.align = [[alNone]]
	CELabel2.enabled = [[true]]
	CELabel2.visible = [[true]]
	AddCEButton = createButton(MyForm)
	AddCEButton.caption = [[Add]]
	AddCEButton.left = [[254]]
	AddCEButton.top = [[0]]
	AddCEButton.width = [[75]]
	AddCEButton.height = [[25]]
	AddCEButton.align = [[alNone]]
	AddCEButton.enabled = [[true]]
	AddCEButton.visible = [[true]]
	AddCEButton.onClick = function ()
	  local addr = UserSymbolCEEdit.Text
	  if addr ~= '' then
		local addy = getMemoryViewForm().DisassemblerView.SelectedAddress
		local extra, mnemonic, bytes, address = splitDisassembledString(disassemble(addy))
		local opcode,operands = mnemonic:match("^(%a+)%s*(.*)")
		userSymbol = UserSymbolCEEdit.text
		CELabel2.caption = string.format("At %X", addy)
		existedSymbol = getNameFromAddress(addy)

		if string.find(existedSymbol,"+") then -- test if there is an associcated symbol
		   print("No symbol")
		else
			print("Symbol: ",existedSymbol)
			unregisterSymbol(existedSymbol)
		end
		registerSymbol(userSymbol,addy)
		print(string.format("At address %X", addy))
		return
	  end
	  print("error")
	end
end