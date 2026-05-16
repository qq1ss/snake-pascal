unit deck_logic;

interface
uses common_types;

procedure InitDeck(var Deck: TDeckOfCells);
function DeckIsEmpty(var Deck: TDeckOfCells): boolean;

procedure PushFront(var Deck: TDeckOfCells; Cell: TCell);
procedure PopFront(var Deck: TDeckOfCells; var Cell: TCell);
procedure PushBack(var Deck: TDeckOfCells; Cell: TCell);
procedure PopBack(var Deck: TDeckOfCells; var Cell: TCell);
function FindCellInDeck(
    var Deck: TDeckOfCells; Cell: TCell): TDeckItemPtr;
procedure DeleteDeckItem(var Deck: TDeckOfCells; var Item: TDeckItemPtr);

implementation

procedure InitDeck(var Deck: TDeckOfCells);
begin
    Deck.first := nil;
    Deck.last := nil
end;

function DeckIsEmpty(var Deck: TDeckOfCells): boolean;
begin
    DeckIsEmpty := (Deck.first = nil) or (Deck.last = nil)
end;

procedure PushFront(var Deck: TDeckOfCells; Cell: TCell);
var
    tmp: TDeckItemPtr;
begin
    new(tmp);
    tmp^.cell := Cell;
    tmp^.next := Deck.first;
    tmp^.prev := nil;
    if Deck.first <> nil then
        Deck.first^.prev := tmp
    else
        Deck.last := tmp;
    Deck.first := tmp
end;

procedure PopFront(var Deck: TDeckOfCells; var Cell: TCell);
var
    tmp: TDeckItemPtr;
begin
    if DeckIsEmpty(Deck) then
        exit;

    tmp := Deck.first;
    Cell := tmp^.cell;
    Deck.first := Deck.first^.next;
    if Deck.first <> nil then
        Deck.first^.prev := nil
    else
        Deck.last := nil;
    dispose(tmp)
end;

procedure PushBack(var Deck: TDeckOfCells; Cell: TCell);
var
    tmp: TDeckItemPtr;
begin
    new(tmp);
    tmp^.cell := Cell;
    tmp^.next := nil;
    tmp^.prev := Deck.last;
    if not DeckIsEmpty(Deck) then
        Deck.last^.next := tmp
    else
        Deck.first := tmp;
    Deck.last := tmp
end;

procedure PopBack(var Deck: TDeckOfCells; var Cell: TCell);
var
    tmp: TDeckItemPtr;
begin
    if DeckIsEmpty(Deck) then
        exit;

    tmp := Deck.last;
    Cell := tmp^.cell;
    Deck.last := Deck.last^.prev;
    if Deck.last <> nil then
        Deck.last^.next := nil
    else
        Deck.first := nil;
    dispose(tmp)
end;

function FindCellInDeck(
    var Deck: TDeckOfCells; Cell: TCell): TDeckItemPtr;
var
    tmp: TDeckItemPtr;
begin
    FindCellInDeck := nil;
    tmp := Deck.first;
    while tmp <> nil do
    begin
        if (tmp^.cell.x = Cell.x) and (tmp^.cell.y = Cell.y) then
        begin
            FindCellInDeck := tmp;
            exit
        end;
        tmp := tmp^.next
    end
end;

procedure DeleteDeckItem(var Deck: TDeckOfCells; var Item: TDeckItemPtr);
var
    tmp_cell: TCell;
begin
    if Item = nil then
        exit;

    if Item^.prev = nil then
        PopFront(Deck, tmp_cell)
    else
    if Item^.next = nil then
        PopBack(Deck, tmp_cell)
    else
    begin
        Item^.next^.prev := Item^.prev;
        Item^.prev^.next := Item^.next;
        dispose(Item);
        Item := nil
    end
end;

end.