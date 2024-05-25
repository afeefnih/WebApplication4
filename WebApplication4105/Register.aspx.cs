using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication4100
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string password = txtPassword.Text;
            PBKDF2Hash hash = new PBKDF2Hash(password);
            string passwordHash = hash.HashedPassword;
            bool enabled = true;

            SqlConnection conn = new SqlConnection(ConfigurationManager.
                ConnectionStrings["connShop"].ConnectionString);

            string sql = @"INSERT INTO UserAccounts Values(@username,@passwordhesh, @role, @enabled)";

            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@username", txtUserName.Text);
            cmd.Parameters.AddWithValue("@passwordhesh", passwordHash);
            cmd.Parameters.AddWithValue("@role", "user");
            cmd.Parameters.AddWithValue("@enabled", enabled);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                lblMessage.Text = "Registration successful";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
            finally
            {
                conn.Close();
            }
        }
    }
}