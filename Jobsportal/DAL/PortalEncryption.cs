using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Security.Cryptography;
namespace DAL
{
   public class PortalEncryption
    {

        public static string Encrypt(string toEncrypt)
        {
            string ret_str = toEncrypt;
            try
            {
                byte[] keyArray;
                byte[] toEncryptArray = UTF8Encoding.UTF8.GetBytes(toEncrypt);


                string key = "drashtajinfotech@Job2019";

                keyArray = UTF8Encoding.UTF8.GetBytes(key);

                TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();

                tdes.Key = keyArray;

                tdes.Mode = CipherMode.ECB;


                tdes.Padding = PaddingMode.PKCS7;

                ICryptoTransform cTransform = tdes.CreateEncryptor();

                byte[] resultArray =
                  cTransform.TransformFinalBlock(toEncryptArray, 0,
                  toEncryptArray.Length);

                tdes.Clear();
                ret_str = Convert.ToBase64String(resultArray, 0, resultArray.Length);
            }
            catch(Exception ex)
            {
                DALError.LogError("PortalEncryption.Encrypt", ex);
            }

            return ret_str;
        }
        public static string Decrypt(string cipherString)
        {
            string ret_str = cipherString.TrimEnd();
            try
            {
                byte[] keyArray;
                

                byte[] toEncryptArray = Convert.FromBase64String(cipherString.TrimEnd());


                string key = "drashtajinfotech@Job2019";
               
                keyArray = UTF8Encoding.UTF8.GetBytes(key);


                TripleDESCryptoServiceProvider tdes = new TripleDESCryptoServiceProvider();
                
                tdes.Key = keyArray;
                

                tdes.Mode = CipherMode.ECB;
                
                tdes.Padding = PaddingMode.PKCS7;

                ICryptoTransform cTransform = tdes.CreateDecryptor();
                byte[] resultArray = cTransform.TransformFinalBlock(
                                     toEncryptArray, 0, toEncryptArray.Length);
                                
                tdes.Clear();
               
                ret_str = UTF8Encoding.UTF8.GetString(resultArray);
            }
            catch (Exception ex)
            {
                DALError.LogError("PortalEncryption.Decrypt", ex);

            }
            return ret_str;
        }
    }
}
