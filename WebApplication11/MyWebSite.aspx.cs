using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data; 

namespace WebApplication11
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TextBoxCalendar.Text = DateTime.Now.ToString("D", new System.Globalization.CultureInfo("en-US"));
                TabContainer1.ActiveTabIndex = 0;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (!TextBoxEditor.Text.Equals(""))
            {
                TabContainer1.ActiveTabIndex = 1;
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            TabContainer1.ActiveTabIndex = 2;
            int numOfFile = calculateNumberOfRecords() + 1;
            writeEditorTextToFile(numOfFile);
            addRecordToDatabase(numOfFile);
            fillAccordion();
        }

        private void fillAccordion()
        {
            string cs = ConfigurationManager.ConnectionStrings["ConnStringDb1"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("Select Date, Filename from tblFiles", con);
                con.Open();
                using (SqlDataReader saReader = cmd.ExecuteReader())
                {
                    while (saReader.Read())
                    {
                        string date = saReader.GetString(0);
                        string filename = saReader.GetString(1);
                        string fileContent = getFileContent(filename);

                        AjaxControlToolkit.AccordionPane ap1 = new AjaxControlToolkit.AccordionPane();
                        ap1.ID = "AccordionPane" + Guid.NewGuid().ToString();
                        ap1.HeaderContainer.Controls.Add(new LiteralControl(date));
                        ap1.ContentContainer.Controls.Add(new LiteralControl(fileContent));
                        Accordion1.Panes.Add(ap1);
                        
                    }
                }
                con.Close();
            }
        }

        private string getFileContent(string filename)
        {
            String rootPath = Server.MapPath("~");
            string fileContent = File.ReadAllText(rootPath + "/Data/" + filename);
            return fileContent;
        }

        private void addRecordToDatabase(int count)
        {
            string cmdString = "INSERT INTO tblFiles (Date, Filename) VALUES (@val1, @val2)";
            string cs = ConfigurationManager.ConnectionStrings["ConnStringDb1"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                try
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.Connection = con;
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = cmdString;
                        cmd.Parameters.AddWithValue("@val1", TextBoxCalendar.Text);
                        cmd.Parameters.AddWithValue("@val2", "file" + count + ".txt");
                        
                        cmd.ExecuteNonQuery();
                    }
                }
                      
                catch(SqlException e)
                {
                    Console.WriteLine(e.StackTrace);
                }
            }
        }
      

        private void writeEditorTextToFile(int count)
        {
            string rootPath = Server.MapPath("~");
            string path = rootPath + "/Data/";
            using (StreamWriter writer = new StreamWriter(path + "file" + count + ".txt", true))
            {
                writer.Write(TextBoxEditor.Text);
            }
           
        }

        private int calculateNumberOfRecords()
        {
            int count = 0;
            string cs = ConfigurationManager.ConnectionStrings["ConnStringDb1"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("Select count (*) from tblFiles", con);
                con.Open();
                count = Convert.ToInt32(cmd.ExecuteScalar());
            }
            return count;
        }

        protected void btLoadFile_Click(object sender, EventArgs e)
        {
            String rootPath = Server.MapPath("~");
            string file = File.ReadAllText(rootPath + "/Data/sourceFile.txt");
            TextBoxEditor.Text = file;
        }   
      
    }
}