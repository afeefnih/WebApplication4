using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication4100
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string sql = @"SELECT * FROM UserAccounts WHERE Username = @Username";
            SqlConnection conn = new SqlConnection(ConfigurationManager.
              ConnectionStrings["connShop"].ConnectionString);

            SqlCommand cmd = new SqlCommand(sql, conn);

            cmd.Parameters.AddWithValue("@Username", txtUserName.Text);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            sda.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                // username found
                Object objpasswordHash = dt.Rows[0]["PasswordHash"];
                Object objRole = dt.Rows[0]["Role"];
                Object objEnabled = dt.Rows[0]["Enabled"];
                string password = txtPassword.Text;
                string storedPasswordHash = objpasswordHash.ToString();
                PBKDF2Hash hash = new PBKDF2Hash(password, storedPasswordHash);
                bool check = hash.PasswordCheck;
                bool enabled = Convert.ToBoolean(objEnabled);

                if (check == true && enabled == true)
                {

                    Session["UserName"] = txtUserName.Text;
                    Session["Role"] = objRole;
                    if (Session["Role"].ToString() == "user")

                        Response.Redirect("WebFormShop.aspx");

                    else if (Session["Role"].ToString() == "admin")

                        Response.Redirect("Admin.aspx");
                }
                else
                {
                    lblMessage.Text = "Incorrect password or account disabled";
                }

            }
            else
            {
                // password incorrect
                lblMessage.Text = "Incorrect username";
            }


        }
    }
}