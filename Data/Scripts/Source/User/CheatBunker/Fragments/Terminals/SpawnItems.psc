;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname CheatBunker:Fragments:Terminals:SpawnItems Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
Proxy.init(akTerminalRef, CollectiblePaginator, CollectibleData)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
CheatBunkerQuest.SpawnItemsContainer.Reset()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
CheatBunkerQuest.WorkbenchContainer.Reset()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

CheatBunker:QuestScript Property CheatBunkerQuest Auto Const

CheatBunker:TerminalSpawnFormList Property CollectiblePaginator Auto Const

DynamicTerminal:ListWrapper:FormList Property CollectibleData Auto Const

DynamicTerminal:PaginationProxy Property Proxy Auto Const

CheatBunker:TerminalSpawnSmallItem Property MiscPaginator Auto Const

DynamicTerminal:ListWrapper:Formlist Property MiscData Auto Const
