using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace MySchedule
{
    public partial class MainForm : Form
    {
        DateTime startdate, enddate;        // 開始日付・終了日付変数
        int starttimeindex, endtimeindex;   //開始時刻、終了時刻
        ScheduleList listitem;              //予定リスト

        public MainForm()
        {
            InitializeComponent();
        }

        // MainFormのLoadイベントハンドラ
        private void MainForm_Load(object sender, EventArgs e)
        {
            InitializeDate();
            listitem = new ScheduleList(); //予定リストクラスからオブジェクト作成
        }

        //Date初期化
        private void InitializeDate()
        {
            monthCalendar1.MaxSelectionCount = 100;

            // 開始日時の設定
            startdate = monthCalendar1.SelectionStart.Date;
            //startTextBox.Text = String.Format("{0:yyyy/MM/dd}", startdate);
            startTextBox.Text = startdate.ToString("d");
            // 終了日時の設定
            enddate = monthCalendar1.SelectionEnd.Date;
            //endTextBox.Text = String.Format("{0:yyyy/MM/dd}", enddate);
            endTextBox.Text = enddate.ToString("d");

            // 開始時刻と終了時刻
            starttimeindex = 46 - DateTime.Now.Hour * 2;
            if (DateTime.Now.Minute > 29)
            {
                if (starttimeindex == 0)
                {
                    starttimeindex = 47;
                }
                else
                {
                    starttimeindex--;
                }
            }
            if (starttimeindex == 0)
            {
                endtimeindex = 47;
            }
            else
            {
                endtimeindex = starttimeindex - 1;
            }
            starttimeDomainUpDown.SelectedIndex = starttimeindex;
            endtimeDomainUpDown.SelectedIndex = endtimeindex;

            // 予定リスト表示エリアに今日の日付を追加
            listviewGroup.Text = startTextBox.Text + " " + listviewGroup.Text;
        }

        // カレンダーのDataChangedイベントハンドラ
        private void monthCalendar1_DateChanged(object sender, DateRangeEventArgs e)
        {
            //開始日付の設定
            startdate = monthCalendar1.SelectionStart.Date;
            startTextBox.Text = String.Format("{0:yyyy/MM/dd}", startdate);

            //終了日付の設定
            enddate = monthCalendar1.SelectionEnd.Date;
            endTextBox.Text = String.Format("{0:yyyy/MM/dd}", enddate);

            //開始時刻と終了時刻の使用許可・不許可
            if (startTextBox.Text == endTextBox.Text)
            {
                starttimeDomainUpDown.Enabled = true;
            }
            else
            {
                starttimeDomainUpDown.Enabled = false;
                endtimeDomainUpDown.Enabled = false;
            }

            //日付＋予定リスト表示
            listviewGroup.Text = startTextBox.Text + " 予定リスト表示";
        }

        // クリアボタンのClickイベントハンドラ
        private void clearButton_Click(object sender, EventArgs e)
        {
            ClearSubject();
        }

        //件名と内容削除
        private void ClearSubject()
        {
            subjectTextBox.Text = null;
            contentTextBox.Text = null;
        }

              //登録ボタンのClickイベントハンドラ
        private void inputButton_Click(object sender, EventArgs e)
        {
                     //件名と内容は入力されているかどうかのチェック
            if (subjectTextBox.Text != "" && contentTextBox.Text != "")
            {
                int subjectcount = Encoding.GetEncoding("UTF-8").GetByteCount(subjectTextBox.Text);
                if (subjectcount > 20)
                {
                    MessageBox.Show("件名を短くしてください。", "予定登録エラー");
                    return;
                }

                string subject = subjectTextBox.Text + new String(' ', 20 - subjectcount);
                string contents = TrimNewLine(contentTextBox.Text);

                //その日の予定
                if (startTextBox.Text == endTextBox.Text)
                {
                    label5.Text = "時間　　　  件名　　　　   内容";
                    ShortItem shortitem = new ShortItem(startTextBox.Text,
                        starttimeDomainUpDown.Text, endtimeDomainUpDown.Text,
                        subject, contents);
                    if (listitem.AddShortitems(shortitem))
                    {
                        scheduleListBox.Items.Clear();
                        foreach (ShortItem shorts in listitem.Shortitems)
                        {
                            scheduleListBox.Items.Add(shorts.Itemall);
                        }
                    }
                    else
                        MessageBox.Show("既に存在する予定です。", "その日の予定エラー");
                }
                //長期の予定
                else
                {
                    label5.Text = "時間　　　  件名　　　　   内容";
                    LongItem longitem = new LongItem(startTextBox.Text,
                        endTextBox.Text, subject, contents);
                    if (listitem.AddLongitems(longitem))
                    {
                        scheduleListBox.Items.Clear();
                        foreach (LongItem longs in listitem.Longitems)
                        {
                            scheduleListBox.Items.Add(longs.Itemall);
                        }
                    }
                    else
                        MessageBox.Show("既に存在する予定です。", "長期の予定エラー");
                }
                ClearSubject(); //件名と内容削除
            }
            else
            {
                MessageBox.Show("件名と内容を入力してください。", "予定登録エラー");
            }
        }

        //ListBoxのSelectedIndexChangedイベントハンドラ
        private void scheduleListBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (scheduleListBox.SelectedIndex != -1)
            {
                //表示ボタンの使用可能/使用不可能を切り替える
                string contents = (string)scheduleListBox.SelectedItem;
                if (Encoding.GetEncoding("UTF-8").GetByteCount(contents) > 59)
                {
                    displayButton.Enabled = true;
                }
                else
                {
                    displayButton.Enabled = false;
                }
                updateButton.Enabled = true;    //修正ボタン
                deleteButton.Enabled = true;    //削除ボタン
            }
        }

        //予定の削除
        private void deleteButton_Click(object sender, EventArgs e)
        {
            if (scheduleListBox.SelectedIndex == -1) return;
            if (scheduleListBox.SelectedItem.ToString().Substring(2, 1) == ":")
            {
                listitem.DeleteShortitems(scheduleListBox.SelectedIndex);
            }
            else
            {
                listitem.DeleteLongitems(scheduleListBox.SelectedIndex);
            }
            scheduleListBox.Items.RemoveAt(scheduleListBox.SelectedIndex);
            if (scheduleListBox.Items.Count == 0)
            {
                displayButton.Enabled = false;
                updateButton.Enabled = false;
                deleteButton.Enabled = false;
            }

        }

        //予定の表示
        private void displayButton_Click(object sender, EventArgs e)
        {
            if (scheduleListBox.SelectedIndex == -1) return;
            DisplayForm displayForm = new DisplayForm();
            //その日の予定表示
            if (label5.Text.IndexOf("時間") >= 0)
            {
                InputForm(displayForm, listitem.SelectShortitems(scheduleListBox.SelectedIndex), "short");
            }
            //長期の予定表示
            else
            {
                InputForm(displayForm, listitem.SelectLongitems(scheduleListBox.SelectedIndex), "long");
            }
            displayForm.ShowDialog();
        }

        //Form入力
        private void InputForm(DisplayForm displayForm, ScheduleItem scheduleitem, string type)
        {
            string[] field = scheduleitem.GetField();
            if (type == "short")
            {
                displayForm.startdateTextBox.Text = field[0];       //開始日付
                displayForm.enddateTextBox.Text = "";               //終了日付
                displayForm.starttimeDomainUpDown.SelectedIndex =   //開始時刻
                    TimeTransformIndex(field[1]);
                displayForm.endtimeDomainUpDown.SelectedIndex =     //終了時刻
                    TimeTransformIndex(field[2]);
            }
            else
            {
                displayForm.startdateTextBox.Text = field[0];   //開始日付
                displayForm.enddateTextBox.Text = field[1];     //終了日付
                displayForm.starttimeDomainUpDown.Text = "";    //開始時刻
                displayForm.endtimeDomainUpDown.Text = "";      //終了時刻
            }
            displayForm.subjectTextBox.Text = scheduleitem.Subject.Trim();  //件名
            displayForm.contentTextBox.Text = scheduleitem.Contents;        //内容
            displayForm.okButton.Select();                                  //OKボタン
        }

        //時刻計算
        private int TimeTransformIndex(string timestring)
        {
            for (int i = 0; i < this.starttimeDomainUpDown.Items.Count; i++)
            {
                if (this.starttimeDomainUpDown.Items[i].ToString() == timestring) return i;
            }
            return -1;
        }
        //予定の修正
        private void updateButton_Click(object sender, EventArgs e)
        {
            bool shortflg = true;
            if (scheduleListBox.SelectedIndex == -1) return;
            UpdateForm updateForm = new UpdateForm();
            //その日の予定表示
            if (label5.Text.IndexOf("時間") >= 0)
            {
                updateForm.enddateTextBox.Enabled = false;
                InputForm2(updateForm,
                    listitem.SelectShortitems(scheduleListBox.SelectedIndex), "short");
            }
            else
            {
                updateForm.starttimeDomainUpDown.Enabled = false;
                updateForm.endtimeDomainUpDown.Enabled = false;
                InputForm2(updateForm,
                    listitem.SelectLongitems(scheduleListBox.SelectedIndex), "long");
                shortflg = false;
            }
            updateForm.ShowDialog();
            if (updateForm.DialogResult == DialogResult.OK)
            {
                if (shortflg)
                    UpdateList(updateForm, "short");
                else
                    UpdateList(updateForm, "long");
            }
        }

        //フォーム入力
        private void InputForm2(UpdateForm updateForm,
            ScheduleItem scheduleitem, string type)
        {
            string[] field = scheduleitem.GetField();
            if (type == "short")
            {
                updateForm.startdateTextBox.Text = field[0];
                updateForm.enddateTextBox.Text = field[0];
                updateForm.starttimeDomainUpDown.SelectedIndex =
                    TimeTransformIndex(field[1]);
                updateForm.endtimeDomainUpDown.SelectedIndex =
                    TimeTransformIndex(field[2]);
            }
            else
            {
                updateForm.startdateTextBox.Text = field[0];
                updateForm.enddateTextBox.Text = field[1];
                updateForm.starttimeDomainUpDown.Text = "";
                updateForm.endtimeDomainUpDown.Text = "";
            }
            updateForm.subjectTextBox.Text = scheduleitem.Subject.Trim();
            updateForm.contentTextBox.Text = scheduleitem.Contents;
            updateForm.okButton.Select();
        }

        //リスト登録
        private void UpdateList(UpdateForm updateForm, string type)
        {
            int subjectcount = Encoding.GetEncoding("UTF-8").GetByteCount(updateForm.subjectTextBox.Text);
            if (subjectcount > 20)
            {
                MessageBox.Show("件名を短くしてください。", "予定登録エラー");
                return;
            }
            string subject = updateForm.subjectTextBox.Text + new String(' ', 20 - subjectcount);
            if (type == "short")
            {
                ShortItem shortitem = new ShortItem(updateForm.startdateTextBox.Text,
                    updateForm.starttimeDomainUpDown.Text,
                    updateForm.endtimeDomainUpDown.Text,
                    subject, updateForm.contentTextBox.Text);
                if (listitem.AddShortitems(shortitem))
                {
                    listitem.DeleteShortitems(scheduleListBox.SelectedIndex);
                    scheduleListBox.Items.Clear();
                    foreach (ShortItem shorts in listitem.Shortitems)
                    {
                        scheduleListBox.Items.Add(shorts.Itemall);
                    }
                }
                else
                    MessageBox.Show("既に存在する予定です。", "その日の予定エラー");
            }
            else
            {
                LongItem longitem = new LongItem(updateForm.startdateTextBox.Text,
                    updateForm.starttimeDomainUpDown.Text,
                    subject, updateForm.contentTextBox.Text);
                if (listitem.AddLongitems(longitem))
                {
                    listitem.DeleteLongitems(scheduleListBox.SelectedIndex);
                    scheduleListBox.Items.Clear();
                    foreach (LongItem longs in listitem.Longitems)
                    {
                        scheduleListBox.Items.Add(longs.Itemall);
                    }
                }
                else
                    MessageBox.Show("既に存在する予定です。", "長期の予定エラー");
            }

        }

              //改行コードを削除
        private string TrimNewLine(string contents)
        {
            int newlineindex = -1;
            int newlinelength = Environment.NewLine.Length;
            while(true)
            {
                newlineindex = contents.IndexOf(Environment.NewLine);
                if (newlineindex == -1)
                    break;
                contents = contents.Remove(newlineindex, newlinelength);
            }
            return contents;        
        }
    }
}
