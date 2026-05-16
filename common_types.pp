unit common_types;

interface
uses crt;

const
    FieldWidth = 80;
    FieldHeight = 40;

    MinScreenWidth = FieldWidth + 2;
    MinScreenHeight = FieldHeight + 2;

    MaxFoodCells = 5;

    BoarderChar = '#';
    SnakeHeadChar = '@';
    SnakeChar = '#';
    FoodChar = '+';

    DelayDuration = 10;

    MessageGameOver = 'GAME OVER';
    MessageYourScore = 'YOUR SCORE';
    MessageQuit = 'PRESS ANY KEY TO QUIT';
    MessagePause = 'GAME PAUSED';

    StepToMove = 10;
    MovesToAddFood = 10;

type
    { Offset }
    TOffset = record
    { Position of left and up cell on field }
        x, y: integer;
    end;

    { Cell }
    TCell = record
        x, y: byte;
        ch: char;
        shown: boolean;
    end;

    { Deck }
    TDeckItemPtr = ^TDeckItem;
    TDeckItem = record
        cell: TCell;
        next, prev: TDeckItemPtr;
    end;
    TDeckOfCells = record
        first, last: TDeckItemPtr;
    end;

    { Snake }
    TDirection = (Up, Down, Left, Right);
    TSnake = record
        deck: TDeckOfCells;
        direction: TDirection;
        grow: boolean;
    end;

    { Food }
    TFood = record
        deck: TDeckOfCells;
        count: byte;
    end;

    { Boarder }
    TBoarder = record
        StartX, StartY, EndX, EndY: integer;
    end;

var
    CenterScreenX, CenterScreenY: integer;
    StartDirection: TDirection;
    StandartTextAttr: integer;
    SnakeStartPosX: byte;
    SnakeStartPosY: byte;

implementation

begin
    CenterScreenX := ScreenWidth div 2;
    CenterScreenY := ScreenHeight div 2;
    StartDirection := Right;
    StandartTextAttr := TextAttr;
    SnakeStartPosX := FieldWidth div 2;
    SnakeStartPosY := FieldHeight div 2
end.