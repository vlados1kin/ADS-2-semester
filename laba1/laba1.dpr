program laba1;

{$APPTYPE CONSOLE}

{$R *.res}

type
  PElem = ^Elem;
  Elem = record
    Data: integer;
    Prev: PElem;
    Next: PElem;
  end;

  PElemUp = ^ElemUp;
  ElemUp = record
    Data: integer;
    Next: PElemUp;
  end;

var
  x, y, EntryPoint1: PElem;
  a, Header, EntryPoint2: PElemUp;
  I, N, Num: integer;
  flag: boolean;

function ReadCorrectly: integer;
var
  S: string;
  Error: integer;
  IsCorrect: boolean;
begin
  repeat
    ReadLn(S);
    Val(S, Result, Error);
    if Error <> 0  then
    begin
      IsCorrect := false;
      WriteLn('Некорректный ввод');
    end
    else
    begin
      if (Length(S) <> 3) and (Length(S) <> 7) then
      begin
        IsCorrect := false;
        WriteLn('Некорректный ввод');
      end
      else
        IsCorrect := true;
    end;
  until IsCorrect;
end;

procedure SortList(var Temp: PElemUp);
var
  x, y: PElemUp;
  TempInt: integer;
begin
  x := Temp;
  while x <> nil do
  begin
    y := x^.next;
    while y <> nil do
    begin
      if y^.data < x^.data then
      begin
        TempInt := y^.data;
        y^.data := x^.data;
        x^.data := TempInt;
      end;
      y := y^.next;
    end;
    x := x^.next;
  end;
end;

begin
  New(x);
  x.Prev := nil;
  Write('Введите количество номеров: ');
  ReadLn(N);
  WriteLn('Введите номера телефонов: ');
  for I := 1 to N do
  begin
    y := x;
    y.Data := ReadCorrectly;
    if I <> N then
    begin
      New(x);
      y.Next := x;
      x.Prev := y;
    end
    else
      y.Next := nil;
  end;
  EntryPoint1 := y;

  WriteLn('Вы ввели список: ');
  while y <> nil do
  begin
    WriteLn(y.Data);
    y := y^.Prev;
  end;

  y := EntryPoint1;
  New(Header);
  a := Header;
  while y^.Data < 1000 do
    y := y^.Prev;
  Header^.Data := y^.Data;
  y := y^.Prev;
  while y <> nil do
  begin
    if y^.Data < 1000 then
      y := y^.Prev
    else
    begin
      New(a^.Next);
      a := a^.Next;
      a^.Data := y^.Data;
      y := y^.Prev;
    end;
  end;
  a^.Next := nil;

  WriteLn('Отсортированный по возрастанию однонаправленный список: ');
  SortList(Header);
  a := Header;
  while a <> nil do
  begin
    WriteLn(a.Data);
    a := a^.next;
  end;

  ReadLn;
end.
