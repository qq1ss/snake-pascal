unit state_game;

interface

procedure GameOver();

implementation
uses crt, dynamicinput, common_types;

procedure GameOver();
var
    code: integer;
    len: byte;
begin
    clrscr;
    len := length('GAME');
    TextColor(Red);
    GotoXY(CenterScreenX - len, CenterScreenY);
    write(MessageGameOver);
    {GotoXY(CenterScreenX - len, CenterScreenY + 2);
    write(MessageYourScore + ' ', stat.score, '!');}
    GotoXY(CenterScreenX - len, ScreenHeight);
    write(MessageQuit);
    GotoXY(1, 1);
    delay(1000);
    GetKey(code);
    TextAttr := StandartTextAttr;
    clrscr;
    halt(0)
end;

end.