using System.Collections.Generic;

namespace Registry.Web.UI.ViewModels
{
    public class AjaxResponseViewModel<T>
    {
        public List<string> Errors { get; private set; } = new List<string>();
        public bool Success { get; set; }
        public T Item { get; set; }
    }
}