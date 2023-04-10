namespace Statline.Common.AppModel.Environment
{
    public interface IEnvironmentVariableSource
    {
        string GetValue(string key);
    }
}
