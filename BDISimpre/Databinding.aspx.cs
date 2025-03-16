using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BDISimpre
{
	public partial class Databinding : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e) {
			GridViewRow gvr = GridView1.SelectedRow;
			Label1.Text = "Valoarea stocului pentru cartea " + gvr.Cells[2].Text
				+ " este " + float.Parse(gvr.Cells[3].Text) * 100;
        }

        protected void Button1_Click(object sender, EventArgs e) {
			String connString = ConfigurationManager.ConnectionStrings[1].ConnectionString;
			SqlConnection sqlConn = new SqlConnection(connString);
			sqlConn.Open();
			SqlCommand insert = new SqlCommand("INSERT INTO [Carte] ([titlu], " +
				"[pret], [idEditura]) VALUES (@titlu, @pret, @idEditura)", sqlConn);
			insert.Parameters.Add(new SqlParameter("@titlu", System.Data.SqlDbType.NVarChar));
			insert.Parameters.Add(new SqlParameter("@pret", System.Data.SqlDbType.Real));
			insert.Parameters.Add(new SqlParameter("@idEditura", System.Data.SqlDbType.Int));

			insert.Parameters["@titlu"].Value = TextBox1.Text;
			insert.Parameters["@pret"].Value = float.Parse(TextBox2.Text);
			insert.Parameters["@idEditura"].Value = DropDownList2.SelectedValue;

			if(insert.ExecuteNonQuery() > 0) {
				Label1.Text = "Inserare cu succes";

			}
			else {
				Label1.Text = "Eroare la inserare";
			}


        }

        protected void Button2_Click(object sender, EventArgs e) {
			GridView2.DataBind();
        }
    }
}