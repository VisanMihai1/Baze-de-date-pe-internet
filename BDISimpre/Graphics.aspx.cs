using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace BDISimpre {
    public partial class Graphics : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {

            if (!IsPostBack) {
                DataSet dataSet = new DataSet();
                String queryString = "SELECT titlu, pret FROM Carte";
                String connString = ConfigurationManager.ConnectionStrings[1].ConnectionString;

                using (SqlConnection sqlConnection = new SqlConnection(connString)) {

                    SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
                    sqlDataAdapter.SelectCommand = new SqlCommand(queryString, sqlConnection);
                    sqlDataAdapter.Fill(dataSet);
                    GridView1.DataSource = dataSet;
                    GridView1.DataBind();
                    Cache["Carti"] = dataSet;
                    Session["Carti"] = dataSet.Tables[0];
                }
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e) {
            Response.Redirect("~/Chart.aspx?tip=" + this.DropDownList1.SelectedValue);
        }
    }
}