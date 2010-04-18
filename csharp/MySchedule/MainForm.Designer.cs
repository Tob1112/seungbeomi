namespace MySchedule
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.fileMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.readMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.writeMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.deleteMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.exitMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.displayMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.shortMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.longMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.helpMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.usingMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.appinfoMenu = new System.Windows.Forms.ToolStripMenuItem();
            this.dateselectGroup = new System.Windows.Forms.GroupBox();
            this.label6 = new System.Windows.Forms.Label();
            this.clearButton = new System.Windows.Forms.Button();
            this.inputButton = new System.Windows.Forms.Button();
            this.contentTextBox = new System.Windows.Forms.TextBox();
            this.subjectTextBox = new System.Windows.Forms.TextBox();
            this.endtimeDomainUpDown = new System.Windows.Forms.DomainUpDown();
            this.endTextBox = new System.Windows.Forms.TextBox();
            this.starttimeDomainUpDown = new System.Windows.Forms.DomainUpDown();
            this.startTextBox = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.monthCalendar1 = new System.Windows.Forms.MonthCalendar();
            this.listviewGroup = new System.Windows.Forms.GroupBox();
            this.deleteButton = new System.Windows.Forms.Button();
            this.updateButton = new System.Windows.Forms.Button();
            this.displayButton = new System.Windows.Forms.Button();
            this.scheduleListBox = new System.Windows.Forms.ListBox();
            this.label5 = new System.Windows.Forms.Label();
            this.menuStrip1.SuspendLayout();
            this.dateselectGroup.SuspendLayout();
            this.listviewGroup.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileMenu,
            this.displayMenu,
            this.helpMenu});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(632, 24);
            this.menuStrip1.TabIndex = 0;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // fileMenu
            // 
            this.fileMenu.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.readMenu,
            this.writeMenu,
            this.deleteMenu,
            this.exitMenu});
            this.fileMenu.Name = "fileMenu";
            this.fileMenu.Size = new System.Drawing.Size(82, 20);
            this.fileMenu.Text = "ファイル(&F)";
            // 
            // readMenu
            // 
            this.readMenu.Name = "readMenu";
            this.readMenu.Size = new System.Drawing.Size(178, 22);
            this.readMenu.Text = "データ読み込み(&R)";
            // 
            // writeMenu
            // 
            this.writeMenu.Name = "writeMenu";
            this.writeMenu.Size = new System.Drawing.Size(178, 22);
            this.writeMenu.Text = "データ書き出し(&W)";
            // 
            // deleteMenu
            // 
            this.deleteMenu.Name = "deleteMenu";
            this.deleteMenu.Size = new System.Drawing.Size(178, 22);
            this.deleteMenu.Text = "削除(&D)";
            // 
            // exitMenu
            // 
            this.exitMenu.Name = "exitMenu";
            this.exitMenu.Size = new System.Drawing.Size(178, 22);
            this.exitMenu.Text = "終了(&X)";
            // 
            // displayMenu
            // 
            this.displayMenu.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.shortMenu,
            this.longMenu});
            this.displayMenu.Name = "displayMenu";
            this.displayMenu.Size = new System.Drawing.Size(59, 20);
            this.displayMenu.Text = "表示(&V)";
            // 
            // shortMenu
            // 
            this.shortMenu.Name = "shortMenu";
            this.shortMenu.Size = new System.Drawing.Size(166, 22);
            this.shortMenu.Text = "その日の予定(&S)";
            // 
            // longMenu
            // 
            this.longMenu.Name = "longMenu";
            this.longMenu.Size = new System.Drawing.Size(166, 22);
            this.longMenu.Text = "長期の予定(&L)";
            // 
            // helpMenu
            // 
            this.helpMenu.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.usingMenu,
            this.appinfoMenu});
            this.helpMenu.Name = "helpMenu";
            this.helpMenu.Size = new System.Drawing.Size(71, 20);
            this.helpMenu.Text = "ヘルプ(&H)";
            // 
            // usingMenu
            // 
            this.usingMenu.Name = "usingMenu";
            this.usingMenu.Size = new System.Drawing.Size(176, 22);
            this.usingMenu.Text = "使い方(&U)";
            // 
            // appinfoMenu
            // 
            this.appinfoMenu.Name = "appinfoMenu";
            this.appinfoMenu.Size = new System.Drawing.Size(176, 22);
            this.appinfoMenu.Text = "バージョン情報(&A)";
            // 
            // dateselectGroup
            // 
            this.dateselectGroup.Controls.Add(this.label6);
            this.dateselectGroup.Controls.Add(this.clearButton);
            this.dateselectGroup.Controls.Add(this.inputButton);
            this.dateselectGroup.Controls.Add(this.contentTextBox);
            this.dateselectGroup.Controls.Add(this.subjectTextBox);
            this.dateselectGroup.Controls.Add(this.endtimeDomainUpDown);
            this.dateselectGroup.Controls.Add(this.endTextBox);
            this.dateselectGroup.Controls.Add(this.starttimeDomainUpDown);
            this.dateselectGroup.Controls.Add(this.startTextBox);
            this.dateselectGroup.Controls.Add(this.label4);
            this.dateselectGroup.Controls.Add(this.label3);
            this.dateselectGroup.Controls.Add(this.label2);
            this.dateselectGroup.Controls.Add(this.label1);
            this.dateselectGroup.Controls.Add(this.monthCalendar1);
            this.dateselectGroup.Location = new System.Drawing.Point(7, 39);
            this.dateselectGroup.Name = "dateselectGroup";
            this.dateselectGroup.Size = new System.Drawing.Size(230, 400);
            this.dateselectGroup.TabIndex = 1;
            this.dateselectGroup.TabStop = false;
            this.dateselectGroup.Text = "日付選択";
            // 
            // label6
            // 
            this.label6.BackColor = System.Drawing.Color.Silver;
            this.label6.Location = new System.Drawing.Point(42, 278);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(180, 1);
            this.label6.TabIndex = 13;
            // 
            // clearButton
            // 
            this.clearButton.Location = new System.Drawing.Point(125, 371);
            this.clearButton.Name = "clearButton";
            this.clearButton.Size = new System.Drawing.Size(75, 23);
            this.clearButton.TabIndex = 12;
            this.clearButton.Text = "クリア";
            this.clearButton.UseVisualStyleBackColor = true;
            this.clearButton.Click += new System.EventHandler(this.clearButton_Click);
            // 
            // inputButton
            // 
            this.inputButton.Location = new System.Drawing.Point(44, 371);
            this.inputButton.Name = "inputButton";
            this.inputButton.Size = new System.Drawing.Size(75, 23);
            this.inputButton.TabIndex = 11;
            this.inputButton.Text = "登録";
            this.inputButton.UseVisualStyleBackColor = true;
            this.inputButton.Click += new System.EventHandler(this.inputButton_Click);
            // 
            // contentTextBox
            // 
            this.contentTextBox.Location = new System.Drawing.Point(14, 320);
            this.contentTextBox.Multiline = true;
            this.contentTextBox.Name = "contentTextBox";
            this.contentTextBox.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.contentTextBox.Size = new System.Drawing.Size(210, 41);
            this.contentTextBox.TabIndex = 10;
            // 
            // subjectTextBox
            // 
            this.subjectTextBox.Location = new System.Drawing.Point(56, 293);
            this.subjectTextBox.MaxLength = 20;
            this.subjectTextBox.Name = "subjectTextBox";
            this.subjectTextBox.Size = new System.Drawing.Size(168, 21);
            this.subjectTextBox.TabIndex = 9;
            // 
            // endtimeDomainUpDown
            // 
            this.endtimeDomainUpDown.Items.Add("23:30");
            this.endtimeDomainUpDown.Items.Add("23:00");
            this.endtimeDomainUpDown.Items.Add("22:30");
            this.endtimeDomainUpDown.Items.Add("22:00");
            this.endtimeDomainUpDown.Items.Add("21:30");
            this.endtimeDomainUpDown.Items.Add("21:00");
            this.endtimeDomainUpDown.Items.Add("20:30");
            this.endtimeDomainUpDown.Items.Add("20:00");
            this.endtimeDomainUpDown.Items.Add("19:30");
            this.endtimeDomainUpDown.Items.Add("19:00");
            this.endtimeDomainUpDown.Items.Add("18:30");
            this.endtimeDomainUpDown.Items.Add("18:00");
            this.endtimeDomainUpDown.Items.Add("17:30");
            this.endtimeDomainUpDown.Items.Add("17:00");
            this.endtimeDomainUpDown.Items.Add("16:30");
            this.endtimeDomainUpDown.Items.Add("16:00");
            this.endtimeDomainUpDown.Items.Add("15:30");
            this.endtimeDomainUpDown.Items.Add("15:00");
            this.endtimeDomainUpDown.Items.Add("14:30");
            this.endtimeDomainUpDown.Items.Add("14:00");
            this.endtimeDomainUpDown.Items.Add("13:30");
            this.endtimeDomainUpDown.Items.Add("13:00");
            this.endtimeDomainUpDown.Items.Add("12:30");
            this.endtimeDomainUpDown.Items.Add("12:00");
            this.endtimeDomainUpDown.Items.Add("11:30");
            this.endtimeDomainUpDown.Items.Add("11:00");
            this.endtimeDomainUpDown.Items.Add("10:30");
            this.endtimeDomainUpDown.Items.Add("10:00");
            this.endtimeDomainUpDown.Items.Add("09:30");
            this.endtimeDomainUpDown.Items.Add("09:00");
            this.endtimeDomainUpDown.Items.Add("08:30");
            this.endtimeDomainUpDown.Items.Add("08:00");
            this.endtimeDomainUpDown.Items.Add("07:30");
            this.endtimeDomainUpDown.Items.Add("07:00");
            this.endtimeDomainUpDown.Items.Add("06:30");
            this.endtimeDomainUpDown.Items.Add("06:00");
            this.endtimeDomainUpDown.Items.Add("05:30");
            this.endtimeDomainUpDown.Items.Add("05:00");
            this.endtimeDomainUpDown.Items.Add("04:30");
            this.endtimeDomainUpDown.Items.Add("04:00");
            this.endtimeDomainUpDown.Items.Add("03:30");
            this.endtimeDomainUpDown.Items.Add("03:00");
            this.endtimeDomainUpDown.Items.Add("02:30");
            this.endtimeDomainUpDown.Items.Add("02:00");
            this.endtimeDomainUpDown.Items.Add("01:30");
            this.endtimeDomainUpDown.Items.Add("01:00");
            this.endtimeDomainUpDown.Items.Add("00:30");
            this.endtimeDomainUpDown.Items.Add("00:00");
            this.endtimeDomainUpDown.Location = new System.Drawing.Point(155, 240);
            this.endtimeDomainUpDown.Name = "endtimeDomainUpDown";
            this.endtimeDomainUpDown.Size = new System.Drawing.Size(68, 21);
            this.endtimeDomainUpDown.TabIndex = 8;
            this.endtimeDomainUpDown.Text = "domainUpDown2";
            this.endtimeDomainUpDown.Wrap = true;
            // 
            // endTextBox
            // 
            this.endTextBox.Location = new System.Drawing.Point(52, 240);
            this.endTextBox.Name = "endTextBox";
            this.endTextBox.ReadOnly = true;
            this.endTextBox.Size = new System.Drawing.Size(100, 21);
            this.endTextBox.TabIndex = 7;
            // 
            // starttimeDomainUpDown
            // 
            this.starttimeDomainUpDown.Items.Add("23:30");
            this.starttimeDomainUpDown.Items.Add("23:00");
            this.starttimeDomainUpDown.Items.Add("22:30");
            this.starttimeDomainUpDown.Items.Add("22:00");
            this.starttimeDomainUpDown.Items.Add("21:30");
            this.starttimeDomainUpDown.Items.Add("21:00");
            this.starttimeDomainUpDown.Items.Add("20:30");
            this.starttimeDomainUpDown.Items.Add("20:00");
            this.starttimeDomainUpDown.Items.Add("19:30");
            this.starttimeDomainUpDown.Items.Add("19:00");
            this.starttimeDomainUpDown.Items.Add("18:30");
            this.starttimeDomainUpDown.Items.Add("18:00");
            this.starttimeDomainUpDown.Items.Add("17:30");
            this.starttimeDomainUpDown.Items.Add("17:00");
            this.starttimeDomainUpDown.Items.Add("16:30");
            this.starttimeDomainUpDown.Items.Add("16:00");
            this.starttimeDomainUpDown.Items.Add("15:30");
            this.starttimeDomainUpDown.Items.Add("15:00");
            this.starttimeDomainUpDown.Items.Add("14:30");
            this.starttimeDomainUpDown.Items.Add("14:00");
            this.starttimeDomainUpDown.Items.Add("13:30");
            this.starttimeDomainUpDown.Items.Add("13:00");
            this.starttimeDomainUpDown.Items.Add("12:30");
            this.starttimeDomainUpDown.Items.Add("12:00");
            this.starttimeDomainUpDown.Items.Add("11:30");
            this.starttimeDomainUpDown.Items.Add("11:00");
            this.starttimeDomainUpDown.Items.Add("10:30");
            this.starttimeDomainUpDown.Items.Add("10:00");
            this.starttimeDomainUpDown.Items.Add("09:30");
            this.starttimeDomainUpDown.Items.Add("09:00");
            this.starttimeDomainUpDown.Items.Add("08:30");
            this.starttimeDomainUpDown.Items.Add("08:00");
            this.starttimeDomainUpDown.Items.Add("07:30");
            this.starttimeDomainUpDown.Items.Add("07:00");
            this.starttimeDomainUpDown.Items.Add("06:30");
            this.starttimeDomainUpDown.Items.Add("06:00");
            this.starttimeDomainUpDown.Items.Add("05:30");
            this.starttimeDomainUpDown.Items.Add("05:00");
            this.starttimeDomainUpDown.Items.Add("04:30");
            this.starttimeDomainUpDown.Items.Add("04:00");
            this.starttimeDomainUpDown.Items.Add("03:30");
            this.starttimeDomainUpDown.Items.Add("03:00");
            this.starttimeDomainUpDown.Items.Add("02:30");
            this.starttimeDomainUpDown.Items.Add("02:00");
            this.starttimeDomainUpDown.Items.Add("01:30");
            this.starttimeDomainUpDown.Items.Add("01:00");
            this.starttimeDomainUpDown.Items.Add("00:30");
            this.starttimeDomainUpDown.Items.Add("00:00");
            this.starttimeDomainUpDown.Location = new System.Drawing.Point(155, 216);
            this.starttimeDomainUpDown.Name = "starttimeDomainUpDown";
            this.starttimeDomainUpDown.Size = new System.Drawing.Size(68, 21);
            this.starttimeDomainUpDown.TabIndex = 6;
            this.starttimeDomainUpDown.Text = "domainUpDown1";
            this.starttimeDomainUpDown.Wrap = true;
            // 
            // startTextBox
            // 
            this.startTextBox.Location = new System.Drawing.Point(52, 216);
            this.startTextBox.Name = "startTextBox";
            this.startTextBox.ReadOnly = true;
            this.startTextBox.Size = new System.Drawing.Size(100, 21);
            this.startTextBox.TabIndex = 5;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.ForeColor = System.Drawing.SystemColors.ActiveCaption;
            this.label4.Location = new System.Drawing.Point(8, 296);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(29, 12);
            this.label4.TabIndex = 4;
            this.label4.Text = "件名";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(8, 274);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(29, 12);
            this.label3.TabIndex = 3;
            this.label3.Text = "登録";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.ForeColor = System.Drawing.SystemColors.ActiveCaption;
            this.label2.Location = new System.Drawing.Point(8, 244);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(29, 12);
            this.label2.TabIndex = 2;
            this.label2.Text = "終了";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.ForeColor = System.Drawing.SystemColors.ActiveCaption;
            this.label1.Location = new System.Drawing.Point(8, 220);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(29, 12);
            this.label1.TabIndex = 1;
            this.label1.Text = "開始";
            // 
            // monthCalendar1
            // 
            this.monthCalendar1.BackColor = System.Drawing.SystemColors.InactiveBorder;
            this.monthCalendar1.Location = new System.Drawing.Point(10, 17);
            this.monthCalendar1.Name = "monthCalendar1";
            this.monthCalendar1.TabIndex = 0;
            this.monthCalendar1.DateChanged += new System.Windows.Forms.DateRangeEventHandler(this.monthCalendar1_DateChanged);
            // 
            // listviewGroup
            // 
            this.listviewGroup.Controls.Add(this.deleteButton);
            this.listviewGroup.Controls.Add(this.updateButton);
            this.listviewGroup.Controls.Add(this.displayButton);
            this.listviewGroup.Controls.Add(this.scheduleListBox);
            this.listviewGroup.Controls.Add(this.label5);
            this.listviewGroup.Location = new System.Drawing.Point(243, 39);
            this.listviewGroup.Name = "listviewGroup";
            this.listviewGroup.Size = new System.Drawing.Size(369, 400);
            this.listviewGroup.TabIndex = 2;
            this.listviewGroup.TabStop = false;
            this.listviewGroup.Text = "予定リスト表示";
            // 
            // deleteButton
            // 
            this.deleteButton.Enabled = false;
            this.deleteButton.Location = new System.Drawing.Point(288, 371);
            this.deleteButton.Name = "deleteButton";
            this.deleteButton.Size = new System.Drawing.Size(75, 23);
            this.deleteButton.TabIndex = 4;
            this.deleteButton.Text = "削除";
            this.deleteButton.UseVisualStyleBackColor = true;
            this.deleteButton.Click += new System.EventHandler(this.deleteButton_Click);
            // 
            // updateButton
            // 
            this.updateButton.Enabled = false;
            this.updateButton.Location = new System.Drawing.Point(207, 371);
            this.updateButton.Name = "updateButton";
            this.updateButton.Size = new System.Drawing.Size(75, 23);
            this.updateButton.TabIndex = 3;
            this.updateButton.Text = "修正";
            this.updateButton.UseVisualStyleBackColor = true;
            this.updateButton.Click += new System.EventHandler(this.updateButton_Click);
            // 
            // displayButton
            // 
            this.displayButton.Enabled = false;
            this.displayButton.Location = new System.Drawing.Point(126, 371);
            this.displayButton.Name = "displayButton";
            this.displayButton.Size = new System.Drawing.Size(75, 23);
            this.displayButton.TabIndex = 2;
            this.displayButton.Text = "表示";
            this.displayButton.UseVisualStyleBackColor = true;
            this.displayButton.Click += new System.EventHandler(this.displayButton_Click);
            // 
            // scheduleListBox
            // 
            this.scheduleListBox.Font = new System.Drawing.Font("Gulim", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.scheduleListBox.FormattingEnabled = true;
            this.scheduleListBox.ItemHeight = 12;
            this.scheduleListBox.Location = new System.Drawing.Point(7, 33);
            this.scheduleListBox.Name = "scheduleListBox";
            this.scheduleListBox.Size = new System.Drawing.Size(356, 328);
            this.scheduleListBox.TabIndex = 1;
            this.scheduleListBox.SelectedIndexChanged += new System.EventHandler(this.scheduleListBox_SelectedIndexChanged);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.ForeColor = System.Drawing.SystemColors.ActiveCaption;
            this.label5.Location = new System.Drawing.Point(6, 17);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(29, 12);
            this.label5.TabIndex = 0;
            this.label5.Text = "予定";
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(632, 466);
            this.Controls.Add(this.listviewGroup);
            this.Controls.Add(this.dateselectGroup);
            this.Controls.Add(this.menuStrip1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MainMenuStrip = this.menuStrip1;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "MainForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "MySchedule";
            this.Load += new System.EventHandler(this.MainForm_Load);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.dateselectGroup.ResumeLayout(false);
            this.dateselectGroup.PerformLayout();
            this.listviewGroup.ResumeLayout(false);
            this.listviewGroup.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem fileMenu;
        private System.Windows.Forms.ToolStripMenuItem readMenu;
        private System.Windows.Forms.ToolStripMenuItem writeMenu;
        private System.Windows.Forms.ToolStripMenuItem deleteMenu;
        private System.Windows.Forms.ToolStripMenuItem exitMenu;
        private System.Windows.Forms.ToolStripMenuItem displayMenu;
        private System.Windows.Forms.ToolStripMenuItem shortMenu;
        private System.Windows.Forms.ToolStripMenuItem longMenu;
        private System.Windows.Forms.ToolStripMenuItem helpMenu;
        private System.Windows.Forms.ToolStripMenuItem usingMenu;
        private System.Windows.Forms.ToolStripMenuItem appinfoMenu;
        private System.Windows.Forms.GroupBox dateselectGroup;
        private System.Windows.Forms.GroupBox listviewGroup;
        private System.Windows.Forms.MonthCalendar monthCalendar1;
        private System.Windows.Forms.Button clearButton;
        private System.Windows.Forms.Button inputButton;
        private System.Windows.Forms.TextBox contentTextBox;
        private System.Windows.Forms.TextBox subjectTextBox;
        private System.Windows.Forms.DomainUpDown endtimeDomainUpDown;
        private System.Windows.Forms.TextBox endTextBox;
        private System.Windows.Forms.DomainUpDown starttimeDomainUpDown;
        private System.Windows.Forms.TextBox startTextBox;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button deleteButton;
        private System.Windows.Forms.Button updateButton;
        private System.Windows.Forms.Button displayButton;
        private System.Windows.Forms.ListBox scheduleListBox;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
    }
}

