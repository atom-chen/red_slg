//---------------------------------------------------------------------------

#ifndef Unit1H
#define Unit1H
//---------------------------------------------------------------------------
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <Vcl.FileCtrl.hpp>
#include <Vcl.Imaging.pngimage.hpp>
#include <Vcl.CheckLst.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Samples.Spin.hpp>
#include <Vcl.Mask.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.ActnCtrls.hpp>
#include <Vcl.ActnMan.hpp>
#include <Data.Bind.Components.hpp>
#include <Data.Bind.EngExt.hpp>
#include <System.Bindings.Outputs.hpp>
#include <System.Rtti.hpp>
#include <Vcl.Bind.DBEngExt.hpp>
#include <Vcl.Bind.Editors.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ActnColorMaps.hpp>
#include <vector>
using std::vector;
//---------------------------------------------------------------------------
class TUIEditForm : public TForm
{
__published:	// IDE-managed Components
	TStatusBar *StatusBar1;
	TSplitter *Splitter1;         //绘图区域与图片区域的分隔条

	//绘图区域
	TPaintBox *PaintBox1;
	TGroupBox *显示;
	TScrollBox *ScrollBox1;   //wjl mark

	//图片处理区域
	TGroupBox *GroupBox1;
	TLabel *Label10;                    //显示图片大小
	TScrollBox *ScrollBox2;
	TImage *ImagePic;
	TListView *ListView1;				//全部资源图片

	//单个UI中的图片名区域
	TGroupBox *GroupBox2;
	TListBox *ListBox1;

	TImage *Image1;          			//wjl mark
	TToolBar *ToolBar1;

	//wjl mark 前四个按钮
	TSpeedButton *SpeedButton1;             //保存
	TSpeedButton *SpeedButton2;             //打开
	TSpeedButton *SpeedButton3;            //新建
	TSpeedButton *SpeedButton4;            //另存为

	//wjl mark 操作按钮
	TButton *Button1;                             //底层按钮
	TButton *Button2;                             //刷新资源按钮
	TButton *Button3;                            //删除按钮
	TButton *Button4;                             //上一层按钮
	TButton *Button5;                            //顶层按钮
	TButton *Button6;                             //克隆按钮
	TButton *Button7;                             //下一层按钮
	TButton *Button8;                             //全选按钮


	TSaveDialog *SaveDialog1;
	TOpenDialog *OpenDialog1;
	TImageList *ImageList1;


	TToolButton *ToolButton1;

	TToolButton *ToolButton2;                   //wjl mark	 偏移按钮
	TSpinEdit *SpinEdit3;
	TSpinEdit *SpinEdit4;
	TToolButton *ToolButton3;

	TToolButton *ToolButton4;


	TActionList *ActionList1;
	TAction *Action1;
	TAction *Action2;
	TAction *Action3;
	//TEdit *Edit7;
	TButton *Button9;
	TPageControl *PageControl1;
	TTabSheet *TabSheet1;
	TBitBtn *BitBtn10;
    TEdit *Edit_searchResource;
    TTreeView *TreeView2;
    TTreeView *TreeView1;
    TPopupMenu *PopupMenu2;
    TMenuItem *MenuItemClear;
    TMenuItem *MenuItemClearAll;
    TPanel *Panel1;
    TLabel *Label2;
    TLabel *Label3;
    TLabel *Label4;
    TLabel *Label5;
    TLabel *Label6;
    TLabel *Label7;
    TLabel *Label8;
    TLabel *Label9;
    TLabel *Label11;
    TLabel *Label_resourceName;
    TLabel *Label_AnimateName;
    TLabel *Label_audio;
    TLabel *Label_scale;
    TLabel *Label_scaleX;
    TLabel *Label_scaleY;
    TLabel *Label_fontName;
    TLabel *Label19;
    TLabel *Label_fontColor;
    TLabel *Label1;
    TEdit *Edit2;
    TEdit *Edit3;
    TEdit *Edit4;
    TEdit *Edit5;
    TEdit *Edit_text;
    TComboBox *ComboBox_type;
    TComboBox *ComboBox_fontAlign;
    TComboBox *ComboBox_fontVAlign;
    TButton *setting;
    TSpinEdit *SpinEdit1;
    TSpinEdit *SpinEdit2;
    TBitBtn *BitBtn1;
    TBitBtn *BitBtn2;
    TBitBtn *BitBtn3;
    TBitBtn *BitBtn4;
    TBitBtn *BitBtn5;
    TBitBtn *BitBtn6;
    TBitBtn *BitBtn7;
    TBitBtn *BitBtn8;
    TBitBtn *BitBtn9;
    TComboBox *ComboBox_fontSize;
    TCheckBox *CheckBox_ExpandSelectRange;
    TComboBox *AnimNameComboBox;
    TEdit *Edit_resourceName;
    TEdit *Edit_audio;
    TCheckBox *LaShenSelectRange;
    TComboBox *ComboBox_fontName;
    TColorBox *ColorBox_fontColor;
    TEdit *Edit_cName;
    TPanel *Panel_optional;
    TLabel *Label_buttonDown;
    TLabel *Label_buttonDisabled;
    TLabel *Label_buttonStatus;
    TLabel *Label_optionalMsg;
    TLabel *Label_buttonChecked;
    TEdit *Edit_buttonDown;
    TEdit *Edit_buttonDisabled;
    TComboBox *ComboBox_buttonStatus;
    TEdit *Edit_buttonChecked;
    TLabel *Label_tag;
    TSpinEdit *SpinEdit_tag;
    TComboBox *ComboBox_useRTF;
    TComboBox *ComboBox_textShade;
    TEdit *Edit_scaleX;
    TEdit *Edit_scaleY;
    TEdit *Edit_G;
    TEdit *Edit_B;
    TLabel *Label12;
    TLabel *Label13;
    TEdit *Edit_R;
    TLabel *Label14;


  /*	TButton *Button9;
	TEdit *AnimIDText;
	TComboBox *AnimNameComboBox;
	TLabel *Label15;
	TLabel *Label16;
	TCheckBox *ExpandSelectRange;
	TComboBox *ComboBox6;
	TComboBox *ComboBox7;
	TLabel *Label17;
	TLabel *Label18;
*/


	void __fastcall paintBoxDragOver(TObject *Sender, TObject *Source, int X, int Y,
          TDragState State, bool &Accept);
	void __fastcall ScrollBox1Resize(TObject *Sender);
	void __fastcall paintBoxMouseUp(TObject *Sender, TMouseButton Button, TShiftState Shift,
          int X, int Y);
	void __fastcall FormShortCut(TWMKey &Msg, bool &Handled);
	void __fastcall Image1DragDrop(TObject *Sender, TObject *Source, int X, int Y);
	void __fastcall Edit_textChange(TObject *Sender);
	void __fastcall Button1Click(TObject *Sender);
	void __fastcall BtnDown(TObject *Sender);
	void __fastcall SpeedButton1Click(TObject *Sender);
	void __fastcall SpeedButton2Click(TObject *Sender);
	void __fastcall Image1MouseMove(TObject *Sender, TShiftState Shift, int X, int Y);
	void __fastcall ListView1SelectItem(TObject *Sender, TListItem *Item, bool Selected);
	void __fastcall SpeedButton3Click(TObject *Sender);
	void __fastcall settingClick(TObject *Sender);
	void __fastcall Button5Click(TObject *Sender);
	void __fastcall ButtonNClick(TObject *Sender);
	void __fastcall BtnDel(TObject *Sender);
	void __fastcall SpeedButton4Click(TObject *Sender);
	void __fastcall SpinEdit1Change(TObject *Sender);
	void __fastcall SpinEdit2Change(TObject *Sender);
	void __fastcall ListBox1Click(TObject *Sender);
	void __fastcall FormKeyUp(TObject *Sender, WORD &Key, TShiftState Shift);
	void __fastcall SpinEdit4Change(TObject *Sender);
	void __fastcall Button2Click(TObject *Sender);
	void __fastcall Image1MouseDown(TObject *Sender, TMouseButton Button, TShiftState Shift,
          int X, int Y);
	void __fastcall BitBtn1Click(TObject *Sender);
	void __fastcall BitBtn4Click(TObject *Sender);
	void __fastcall BitBtn2Click(TObject *Sender);
	void __fastcall BitBtn3Click(TObject *Sender);
	void __fastcall BitBtn5Click(TObject *Sender);
	void __fastcall BitBtn6Click(TObject *Sender);
	void __fastcall BitBtn7Click(TObject *Sender);
	void __fastcall BitBtn8Click(TObject *Sender);
	void __fastcall BitBtn9Click(TObject *Sender);
	void __fastcall Button8Click(TObject *Sender);
	void __fastcall Action1Execute(TObject *Sender);
	void __fastcall Action2Execute(TObject *Sender);
	void __fastcall Action3Execute(TObject *Sender);
	void __fastcall SpinEdit_groupChange(TObject *Sender);
	void __fastcall Button6Click(TObject *Sender);
	void __fastcall Button9Click(TObject *Sender);
	void __fastcall Edit_audioChange(TObject *Sender);
	void __fastcall AnimNameComboBoxChange(TObject *Sender);
	void __fastcall CheckBox_ExpandSelectRangeMouseUp(TObject *Sender, TMouseButton Button, TShiftState Shift,
		  int X, int Y);
	void __fastcall LaShenSelectRangeMouseUp(TObject *Sender, TMouseButton Button, TShiftState Shift,
		  int X, int Y);
	void __fastcall ListView2SelectItem(TObject *Sender, TListItem *Item, bool Selected);
	void __fastcall Panel1Click(TObject *Sender);
	void __fastcall ColorBox_fontColorChange(TObject *Sender);
	void __fastcall ComboBox_fontSizeChange(TObject *Sender);
	void __fastcall LaShenSelectRangeClick(TObject *Sender);
	void __fastcall CheckBox_ExpandSelectRangeClick(TObject *Sender);
	void __fastcall Edit_buttonDisabledChange(TObject *Sender);
	void __fastcall Edit_buttonDownChange(TObject *Sender);
    void __fastcall ComboBox_buttonStatusChange(TObject *Sender);
    void __fastcall FormDestroy(TObject *Sender);
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall Edit_buttonCheckedChange(TObject *Sender);
    void __fastcall Edit_resourceNameChange(TObject *Sender);
    void __fastcall SpinEdit_tagChange(TObject *Sender);
    void __fastcall TreeView1Click(TObject *Sender);
    void __fastcall MenuItemClearClick(TObject *Sender);
    void __fastcall MenuItemClearAllClick(TObject *Sender);
    void __fastcall PopupMenu2Popup(TObject *Sender);
    void __fastcall Edit_cNameChange(TObject *Sender);
    void __fastcall ComboBox_textShadeChange(TObject *Sender);
    void __fastcall ComboBox_useRTFChange(TObject *Sender);
    void __fastcall Edit_scaleXChange(TObject *Sender);
    void __fastcall Edit_scaleYChange(TObject *Sender);
    void __fastcall Edit_searchResourceChange(TObject *Sender);



private:	// User declarations
    void __fastcall AcceptFiles (TMessage& Msg);



public:		// User declarations
	__fastcall TUIEditForm(TComponent* Owner);
	BEGIN_MESSAGE_MAP

	MESSAGE_HANDLER(WM_DROPFILES, TMessage, AcceptFiles)

	END_MESSAGE_MAP(TForm)
public:
    void __fastcall Edit_resourceNameCheck();
    void __fastcall ProgressBarInit();
    void __fastcall ProgressBarHide();

    void __fastcall ProgressBarChanged(TObject *Sender);
    void __fastcall ProgressBarShow();
    void __fastcall ProgressBarDistroy();

    void __fastcall SortTestCompare(TObject *Sender, TListItem *Item1,TListItem *Item2, int Data, int &Compare);

    void __fastcall FrameInit();
    void __fastcall ComboBox_frameTypeOnChange(TObject *Sender);
    void __fastcall OnItemChange(TObject *Sender);
    bool __fastcall CheckcName();

    void __fastcall PanelAllHide()
    {
        for (size_t i = 0; i != m_panel.size(); i++)
        {
           // m_panel[i]->Visible = false;
            if (m_panel[i]->Visible == false)
            {
                continue;
            }
           m_panel[i]->Hide();
           char data[16];
           sprintf(data, "%d, hide\r\n", i);
           OutputDebugStringA(data);
        }
    }

    void __fastcall PanelShow(size_t index)
    {
        assert(index < m_panel.size());
        PanelAllHide();
        m_panel[index]->Show();
        char data[16];
        sprintf(data, "%d, Show\r\n", index);
        OutputDebugStringA(data);
       // m_panel[index]->Visible = true;
    }

    void __fastcall PanelHide(size_t index)
    {
        assert(index < m_panel.size());
        m_panel[index]->Hide();
        char data[16];
        sprintf(data, "%d, hide\r\n", index);
        OutputDebugStringA(data);
       // m_panel[index]->Visible = false;
    }

    TPanel* __fastcall GetPanel(size_t index)
    {
        assert(index < m_panel.size());
        return m_panel[index];
    }
    void __fastcall addColor(UnicodeString name, int color);
    int __fastcall findColor(int color);
    void __fastcall clearColor();
public:
    vector<TPanel *>        m_panel;

    TLabel* labelProgressBar[6];

    TEdit *Edit_progressBarImage;
    TEdit *Edit_progressBarX;
    TEdit *Edit_progressBarY;
    TEdit *Edit_progressBarWidth;
    TEdit *Edit_progressBarHeight;


    TComboBox *ComboBox_frameType;
    TComboBox *ComboBox_progressBarValue;
    TComboBox *ComboBox_scrollListAlign;
    TComboBox *ComboBox_scrollPageAlign;
    TComboBox *ComboBox_scrollViewAlign;

    TEdit *Edit_scrollListMargin;
    TEdit *Edit_scrollPageMargin;

    //TComboBox *ComboBox_textShade;

    bool ProgressBarChangePending;
    bool ButtonChangePending;
    void ButtonEventPending(bool b){ ButtonChangePending = b;}

    bool fontColorChange;
};
//---------------------------------------------------------------------------
extern PACKAGE TUIEditForm *UIEditForm;
//---------------------------------------------------------------------------
#endif
