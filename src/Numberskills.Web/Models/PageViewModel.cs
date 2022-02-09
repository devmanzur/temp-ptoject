namespace Numberskills.Web.Models;

public class PageViewModel<T> where T : class
{
    public PageViewModel(List<T> items, int count)
    {
        Result = items;
        Count = count;
    }

    public List<T> Result { get; private set; }
    public int Count { get; private set; }
}