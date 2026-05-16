unit food_logic;

interface
uses common_types;

procedure InitFood(var Food: TFood);
procedure NewFood(var Food: TFood; var Snake: TSnake);
procedure DeleteFood(var Food: TFood; Cell: TCell);
procedure ShowAllFood(var Food: TFood; Offset: TOffset);
procedure HideAndDelOneFood(var Food: TFood; Cell: TCell; Offset: TOffset);

implementation
uses crt, cell_logic, deck_logic;

procedure InitFood(var Food: TFood);
begin
    InitDeck(Food.deck);
    Food.count := 0
end;

function RandomCellInSnake(Cell: TCell; var Snake: TSnake): boolean;
begin
    RandomCellInSnake := FindCellInDeck(Snake.deck, Cell) <> nil;
end;

procedure NewFood(var Food: TFood; var Snake: TSnake);
var
    tmp_cell: TCell;
begin
    if Food.count >= MaxFoodCells then
        exit;

    repeat
        tmp_cell := RandomXYCell(FoodChar)
    until (not RandomCellInSnake(tmp_cell, Snake));

    PushFront(Food.deck, tmp_cell);
    Food.count := Food.count + 1
end;

procedure DeleteFood(var Food: TFood; Cell: TCell);
var
    Item: TDeckItemPtr;
begin
    Item := FindCellInDeck(Food.deck, Cell);
    if Item = nil then
        exit;

    DeleteDeckItem(Food.deck, Item);
    Food.count := Food.count - 1
end;

procedure ShowAllFood(var Food: TFood; Offset: TOffset);
var
    tmp: TDeckItemPtr;
begin
    tmp := Food.deck.first;

    while tmp <> nil do
    begin
        ShowCell(tmp^.cell, Offset);
        tmp := tmp^.next
    end
end;

procedure HideAndDelOneFood(var Food: TFood; Cell: TCell; Offset: TOffset);
begin
    HideCell(Cell, Offset);
    DeleteFood(Food, Cell)
end;

end.