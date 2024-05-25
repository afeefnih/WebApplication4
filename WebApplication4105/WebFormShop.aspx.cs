using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//important extension
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication4105
{
    public partial class WebFormShop : System.Web.UI.Page
    {
        static double totalAmount;
        protected void Page_Load(object sender, EventArgs e)
        {
            //The code checks if the current HTTP request is the first time the page
            //is being loaded (i.e., it is not a postback) and, if so,
            //calls the GenerateSalesId method.
            //Other meaning, the Sales ID will not change if the user click any button

            if (Session["Role"] == null)
            {
                Response.Redirect("default.aspx");
            }

            if (!IsPostBack)
            {
                GenerateSalesId();
            }
            
        }

        void GenerateSalesId()
        {
            string hexTicks = DateTime.Now.Ticks.ToString("X");
            lblSalesId.Text = hexTicks.Substring(hexTicks.Length -15, 9);
            lblDateTime.Text = DateTime.Now.ToString();
        }

        protected void GridViewItems_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblItemId.Text = GridViewItems.SelectedRow.Cells[1].Text;
            lblItemTitle.Text = GridViewItems.SelectedRow.Cells[2].Text;
            lblItemPrice.Text = GridViewItems.SelectedRow.Cells[3].Text;
        }

        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            SalesAddItem();
            //DataBind() => Every time there are an update sales
            //this grid view will updaetd too
            GridViewCart.DataBind();
            SalesGetTotalAmount();
        }

        void SalesAddItem()
        {
            //Create Connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.
                ConnectionStrings["connShop"].ConnectionString);

            //Create command object woth Stored Procedure name
            SqlCommand cmd = new SqlCommand("spSalesAddItem", conn);

            //Set command oonject for stored procedure excution
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@salesid", lblSalesId.Text);
            cmd.Parameters.AddWithValue("@itemid", lblItemId.Text);
            cmd.Parameters.AddWithValue("@quantity", txtQuantity.Text); 
            
            try
            {
                //open connection
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch(SqlException ex) 
            {
                lblMessage1.Text = ex.Message;
            }
            finally 
            { 
                conn.Close();
            }

            txtQuantity.Text = "1";
        }

        void SalesGetTotalAmount()
        {
            //Create connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.
                ConnectionStrings["connShop"].ConnectionString);

            //Create command object woth Stored Procedure name
            SqlCommand cmd = new SqlCommand("spSalesGetTotalAmount", conn);

            //Set command oonject for stored procedure excution
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@salesid", lblSalesId.Text);

            try
            {
                conn.Open() ;
                totalAmount =(double)cmd.ExecuteScalar();
                lblTotalAmountCart.Text = totalAmount.ToString("n2");
            }
            catch(SqlException ex)
            {
                lblMessage2.Text = ex.Message;
            }
            finally
            {
                conn.Close() ;
            }

            
        }

        void SalesConfirm()
        {
            //Create connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.
                ConnectionStrings["connShop"].ConnectionString);

            //Create command object woth Stored Procedure name
            SqlCommand cmd = new SqlCommand("spSalesConfirm", conn);

            //Set command oonject for stored procedure excution
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@salesid", lblSalesId.Text);

            try
            {
                //Open connenction
                conn.Open() ;
                cmd.ExecuteNonQuery();
                lblMessage2.Text = "Sales Confirmed";
            }
            catch(SqlException ex)
            {
                lblMessage2 .Text = ex.Message;
            }
            finally
            {
                conn.Close();
            }

            txtQuantity.Text = "1";

        }

        void DisplayInvoice()
        {
            double serciveTax, amountAfterTax, amountRounded, rounding;
            serciveTax = totalAmount * 0.06;
            amountAfterTax = totalAmount + serciveTax;
            amountRounded = Math.Round((amountAfterTax) / 0.05) * 0.05;
            rounding = amountRounded - amountAfterTax;

            lblTotalAmount.Text = "Total amount: RM" + totalAmount.ToString("n2");
            lblServiceTax.Text = "Service tax (6%): RM" + serciveTax.ToString("n2");
            lblAmountAfterTax.Text = "Amount after tax: RM" + amountAfterTax.ToString("n2");
            lblRounding.Text = "Rounding: RM" + rounding.ToString("n2");
            lblAmountRounded.Text = "Amount to pay: RM" + amountRounded.ToString("n2");
        }

        void ClearAll() 
        {
            lblItemId.Text = "";
            lblItemTitle.Text = "";
            lblItemPrice.Text = "";
            lblTotalAmountCart.Text = "RM0.00";
            lblTotalAmount.Text = "";
            lblServiceTax.Text = "";
            lblAmountAfterTax.Text = "";
            lblRounding.Text = "";
            lblAmountRounded.Text = "";
            lblMessage1.Text = "";
            lblMessage2.Text = "";
        }

        void SalesRemoveNotConfirmed()
        {
            //Create connection
            SqlConnection conn = new SqlConnection(ConfigurationManager.
                ConnectionStrings["connShop"].ConnectionString);

            //Create command object woth Stored Procedure name
            SqlCommand cmd = new SqlCommand("spSalesRemoveNotConfirmed", conn);

            //Set command oonject for stored procedure excution
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@sales", lblSalesId.Text);

            try
            {
                //Open connenction
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch(SqlException ex) 
            {
                lblMessage2.Text = ex.Message;
            }
            finally
            {
                conn.Close();
            }
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            //reset the paging
            GridViewItems.PageIndex = 0;
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            SalesConfirm();
            DisplayInvoice();
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            ClearAll();
            //generate new sales id after user click 'New Sales' button
            GenerateSalesId();
            ddlCategory.DataBind();
            GridViewItems.PageIndex = 0;
            GridViewItems.DataBind();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            SalesRemoveNotConfirmed();
            ClearAll();
            GenerateSalesId();
            ddlCategory.DataBind();
            GridViewItems.PageIndex = 0;
            GridViewItems.DataBind();
        }
    }
}