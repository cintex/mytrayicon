unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.RegularExpressions, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    Close1: TMenuItem;
    Show1: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    procedure FormDestroy(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Show1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
  private
    isRealClose: Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  h: HMENU;
begin
  h := GetSystemMenu(Handle, False);
  DeleteMenu(h, 6, MF_BYPOSITION);
  DeleteMenu(h, 5, MF_BYPOSITION);
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
  isRealClose := True;
  Close;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if isRealClose then
  begin
    isRealClose := MessageDlg('真的要退出吗？', mtConfirmation, [mbYes, mbCancel], 0, mbYes) = mrYes;
    CanClose := isRealClose;
  end
  else
  begin
    Self.WindowState := wsMinimized;
    CanClose := False;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  isRealClose := False;
end;

procedure TForm1.FormDestroy(Sender: TObject);
const
  batFile = 'tmp.bat';
begin
  ChDir(ExtractFilePath(Application.ExeName));
  with TStringList.Create do
  begin
    Add(':LOOP');
    Add('del ' + ExtractFileName(ParamStr(0)));
    Add('IF Exist ' + ExtractFileName(ParamStr(0)) + ' GOTO LOOP');
    Add('del %0');
    SaveToFile(batFile);
    Free;
  end;
  WinExec(batFile, SW_HIDE);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  if Self.WindowState = wsMinimized then
  begin
    { 指定图标, 这里是用程序相同的图标; 也可在设计时选择, 还可以指定一个图标组, 再用 IconIndex 切换 }
    TrayIcon1.Icon := Application.Icon;
    { 指定右键菜单 }
    TrayIcon1.PopupMenu := PopupMenu1;
    { 使之可见 }
    TrayIcon1.Visible := True;
    { 隐藏窗体 }
    Self.Hide;
  end;
end;

procedure TForm1.Show1Click(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Self.WindowState := wsNormal;
  Self.Show;
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
  ShowMessage('OnDblClick');
end;

{
  AssignFile(fp, '~Del_MySelf.Bat');
  ReWrite(fp);
  WriteLn(fp, ':Loop');
  WriteLn(fp, 'Del Register.exe');
  WriteLn(fp, 'IF Exist Register.exe Goto Loop');
  WriteLn(fp, 'Del %0');
  CloseFile(fp);
  winexec('~Del_MySelf.Bat',sw_hide);//隐藏窗口运行a.bat

}
end.
