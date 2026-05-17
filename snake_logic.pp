unit snake_logic;

interface
uses common_types;

procedure InitSnake(var Snake: TSnake);
procedure ShowAllSnake(var Snake: TSnake; Offset: TOffset);
procedure MoveSnake(
    var Snake: TSnake; var Food: TFood; Offset: TOffset; Boarder: TBoarder);

implementation
uses crt, cell_logic, deck_logic, food_logic, state_game;

procedure InitSnake(var Snake: TSnake);
begin
    InitDeck(Snake.deck);
    PushFront(Snake.deck, InitCell(SnakeStartPosX, SnakeStartPosY, SnakeHeadChar));
    Snake.direction := StartDirection;
    Snake.grow := false
end;

procedure ShowAllSnake(var Snake: TSnake; Offset: TOffset);
var
    tmp: TDeckItemPtr;
begin
    tmp := Snake.deck.first;

    while tmp <> nil do
    begin
        ShowCell(tmp^.cell, Offset);
        tmp := tmp^.next
    end
end;

function SnakeEatFood(var Snake: TSnake; var Food: TFood): boolean;
var
    tmp: TDeckItemPtr;
begin
    tmp := Food.deck.first;
    while tmp <> nil do
    begin
        if (Snake.deck.first^.cell.x = tmp^.cell.x) and
            (Snake.deck.first^.cell.y = tmp^.cell.y) then
        begin
            SnakeEatFood := true;
            exit
        end;
        tmp :=  tmp^.next
    end;
    SnakeEatFood := false
end;

function SnakeBumpIntoWall(var Snake: TSnake; Boarder: TBoarder): boolean;
begin
    SnakeBumpIntoWall :=
        (Snake.deck.first^.cell.x = Boarder.StartX) or
        (Snake.deck.first^.cell.x = Boarder.EndX) or
        (Snake.deck.first^.cell.y = Boarder.StartY) or
        (Snake.deck.first^.cell.y = Boarder.EndY)
end;

function SnakeBumpIntoTail(var Snake: TSnake): boolean;
var
    tmp: TDeckItemPtr;
begin
    tmp := Snake.deck.first^.next;
    while tmp <> nil do
    begin
        if (Snake.deck.first^.cell.x = tmp^.cell.x) and
            (Snake.deck.first^.cell.y = tmp^.cell.y) then
        begin
            SnakeBumpIntoTail := true;
            exit
        end;
        tmp :=  tmp^.next
    end;
    SnakeBumpIntoTail := false
end;

procedure CheckGameOver(var Snake: TSnake; Boarder: TBoarder);
begin
    if SnakeBumpIntoWall(Snake, Boarder) or SnakeBumpIntoTail(Snake) then
        GameOver()
end;

procedure MoveSnake(
    var Snake: TSnake; var Food: TFood; Offset: TOffset; Boarder: TBoarder);
var
    next_cell: TCell;
    x, y: byte;
    Item: TDeckItemPtr;
begin
    TextColor(Green);
    x := Snake.deck.first^.cell.x;
    y := Snake.deck.first^.cell.y;

    case Snake.direction of
        Up:
            y := y - 1;
        Down:
            y := y + 1;
        Left:
            x := x - 1;
        Right:
            x := x + 1;
    end;
    HideCell(Snake.deck.first^.cell, Offset);
    Snake.deck.first^.cell.ch := SnakeChar;
    ShowCell(Snake.deck.first^.cell, Offset);
    next_cell := InitCell(x, y, SnakeHeadChar);
    if not Snake.grow then
    begin
        Item := FindCellInDeck(Snake.deck, Snake.deck.last^.cell);
        Snake.deck.last^.cell.shown := true;
        HideCell(Snake.deck.last^.cell, Offset);
        DeleteDeckItem(Snake.deck, Item)
    end
    else
        Snake.grow := not Snake.grow;
    PushFront(Snake.deck, next_cell);
    { GameOver if Snake bump into wall or tail }
    CheckGameOver(Snake, Boarder);
    ShowCell(Snake.deck.first^.cell, Offset);
    if SnakeEatFood(Snake, Food) then
    begin
        Snake.grow := true;
        DeleteFood(Food, Snake.deck.first^.cell)
    end
end;

end.