using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Security.Cryptography;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Configuration;

namespace AS_Assignment
{
    public partial class Registration : System.Web.UI.Page
    {
        string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                SqlConnection conn = new SqlConnection(MYDBConnectionString);
                conn.Open();
                string checkuser = "select count(*) from Account where Email='" + Email_TxtBox.Text + "'";
                SqlCommand com = new SqlCommand(checkuser, conn);
                int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
                conn.Close();
                if (temp == 1)
                {
                    Response.Write("User already Exists");
                }
            }

        }

   

        protected void Submit_Click(object sender, EventArgs e)
        {
            string pwd = pwd_txtBox.Text.ToString().Trim(); ;
            
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] saltByte = new byte[8];
           
            rng.GetBytes(saltByte);
            salt = Convert.ToBase64String(saltByte);

            SHA512Managed hashing = new SHA512Managed();

            string pwdWithSalt = pwd + salt;
            byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
            byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));

            finalHash = Convert.ToBase64String(hashWithSalt);

            RijndaelManaged cipher = new RijndaelManaged();
            cipher.GenerateKey();
            Key = cipher.Key;
            IV = cipher.IV;

            createAccount();
            Response.Redirect("Login.aspx");
            lbl_error.Text = "Password Complexity - Excellent!";
        }

        private void createAccount()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(MYDBConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("insert into Account values(@FirstName,@LastName,@Email,@CreditCre,@PasswordHash,@PasswordSalt,@DateTimeRegistered,@DateOfBirth,@Photo,@IV,@Key,@Islocked,@attemptcount )"))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                                
                            cmd.Parameters.AddWithValue("@FirstName", Fn_TxtBox.Text.Trim());
                            cmd.Parameters.AddWithValue("@LastName", Ln_TxtBox.Text.Trim());
                            cmd.Parameters.AddWithValue("@Email", Email_TxtBox.Text.Trim());
                            cmd.Parameters.AddWithValue("@CreditCre", Convert.ToBase64String(encryptData(Credit_TextBx.Text.Trim())));
                            cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                            cmd.Parameters.AddWithValue("@PasswordHash", finalHash);
                            cmd.Parameters.AddWithValue("@DateTimeRegistered", DateTime.Now);
                            cmd.Parameters.AddWithValue("@DateOfBirth", dob_txtBox.Text.Trim());
                            if (image_upload.HasFile)
                            {
                                string fileName = Path.GetFileName(image_upload.PostedFile.FileName);
                                image_upload.PostedFile.SaveAs(Server.MapPath("~/Upload/") + fileName);
                                cmd.Parameters.AddWithValue("@Photo", fileName);
                            }
                            cmd.Parameters.AddWithValue("@IV", Convert.ToBase64String(IV));
                            cmd.Parameters.AddWithValue("@Key", Convert.ToBase64String(Key));
                            cmd.Parameters.AddWithValue("@Islocked", 0);
                            cmd.Parameters.AddWithValue("attemptcount", 0);
                            cmd.Connection = con;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                }
              
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
        }


        protected byte [] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return cipherText;
        }
    }
}


