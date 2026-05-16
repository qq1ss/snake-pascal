program SnakeGame;
uses crt, dynamicinput, common_types, field_logic, snake_logic, food_logic,
    offset_logic;

var
    SaveTextAttr: integer;
    Code: integer;

    Offset: TOffset;
    Boarder: TBoarder;

    Food: TFood;
    Snake: TSnake;

    Step, MovesForFood: byte;
    PrevSnakeDirection: TDirection;

begin
    { Prepare Program }
    CheckMinScreenSize();
    PrepareScreen(SaveTextAttr);
    randomize;

    { Init Section }
    InitOffset(Offset);
    InitBoarder(Boarder);
    Step := 0;
    MovesForFood := 0;

    InitFood(Food);
    InitSnake(Snake);

    { Prepare to cycle }
    ShowBoarder(Boarder, Offset);
    ShowAllSnake(Snake, Offset);
    NewFood(Food, Snake);
    ShowAllFood(Food, Offset);

    { game }
    while true do
    begin
        if KeyPressed then
        begin
            GetKey(Code);
            PrevSnakeDirection := Snake.direction;
            case Code of
                KeyUp:
                begin
                    if PrevSnakeDirection <> Down then
                        Snake.direction := Up;
                end;
                KeyDown:
                begin
                    if PrevSnakeDirection <> Up then
                        Snake.direction := Down;
                end;
                KeyLeft:
                begin
                    if PrevSnakeDirection <> Right then
                        Snake.direction := Left;
                end;
                KeyRight:
                begin
                    if PrevSnakeDirection <> Left then
                        Snake.direction := Right;
                end;
                KeyEscape:
                    break;
            end
        end;
        delay(DelayDuration);
        Step := Step + 1;

        if Step >= StepToMove then
        begin
            Step := 0;
            MovesForFood := MovesForFood + 1;
            MoveSnake(Snake, Food, Offset, Boarder);
            if MovesForFood >= MovesToAddFood then
            begin
                MovesForFood := 0;
                NewFood(Food, Snake);
                ShowAllFood(Food, Offset)
            end
        end
    end;

    TextAttr := StandartTextAttr;
    clrscr
end.
