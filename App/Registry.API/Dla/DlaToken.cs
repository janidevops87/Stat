namespace Registry.API.Dla
{
    /// <summary>
    /// The token object that is sent from the dla authorization url
    /// </summary>
    public class DlaToken
    {
        public string Access_Token { get; set; }
        public int Expires_In { get; set; }
        public string Token_Type { get; set; }
    }
}
