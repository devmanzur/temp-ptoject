namespace Numberskills.Web.Models
{
    public class ResponseViewModel
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public object Data { get; set; }

        public static ResponseViewModel Ok(object data = null, string message = "Success")
        {
            return new ResponseViewModel
            {
                Success = true,
                Message = message,
                Data = data
            };
        }

        public static ResponseViewModel Error(string message = null, object data = null)
        {
            return new ResponseViewModel
            {
                Success = false,
                Message = message,
                Data = data
            };
        }
    }
}