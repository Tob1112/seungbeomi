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
    public partial class UpdateForm : Form
    {
        public UpdateForm()
        {
            InitializeComponent();
        }

        private void cancelButton_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void okButton_Click(object sender, EventArgs e)
        {
            try
            {
                //その日の予定
                if (enddateTextBox.Enabled == false)
                {
                    if (DateTime.Parse(endtimeDomainUpDown.Text) <=
                       DateTime.Parse(starttimeDomainUpDown.Text))
                    {
                        MessageBox.Show("開始時刻より終了時刻が前です。", "時刻エラー");
                        this.DialogResult = DialogResult.Cancel;
                        return;
                    }
                    DateTime sdate = DateTime.Parse(starttimeDomainUpDown.Text);
                }
                else
                { 
                    if(DateTime.Parse(startdateTextBox.Text) >=
                       DateTime.Parse(enddateTextBox.Text))
                    {
                        MessageBox.Show("開始日付より終了日付が前です。","日付エラー");
                        this.DialogResult = DialogResult.Cancel;
                        return;
                    }
                }
            }
            catch
            {
                MessageBox.Show("日付の形式や時刻の形式が不正です。","日付時刻エラー");
                this.DialogResult = DialogResult.Cancel;
                return;
            }
            if(subjectTextBox.Text == "")
            {
                MessageBox.Show("件名を入力してください。","件名エラー");
                this.DialogResult = DialogResult.Cancel;
                return;
            }
            if (contentTextBox.Text == "")
            {
                MessageBox.Show("内容を入力してください。","内容エラー");
                this.DialogResult = DialogResult.Cancel;
                return;
            }
            this.Close();
        }
    }
}
