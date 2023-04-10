namespace System.Threading.Tasks
{
    public static class TaskExtensions
    {
        // Borrowed from here: https://github.com/dotnet/corefx/blob/407c09d5840384fbd24bbd5b8869ef13be71de63/src/Common/tests/System/Threading/Tasks/TaskTimeoutExtensions.cs#L28-L43
        public static async Task TimeoutAfter(this Task task, TimeSpan timeout)
        {
            using (var cts = new CancellationTokenSource())
            {
                if (task == await Task.WhenAny(task, Task.Delay(timeout, cts.Token)).ConfigureAwait(false))
                {
                    cts.Cancel();
                    await task.ConfigureAwait(false);
                }
                else
                {
                    throw new TimeoutException($"Task timed out after {timeout}");
                }
            }
        }

        public static Task TimeoutAfter(this Task task, int millisecondsTimeout) =>
            task.TimeoutAfter(TimeSpan.FromMilliseconds(millisecondsTimeout));

        public static async Task<TResult> TimeoutAfter<TResult>(
            this Task<TResult> task,
            TimeSpan timeout)
        {
            using (var cts = new CancellationTokenSource())
            {
                if (task == await Task<TResult>.WhenAny(task, Task<TResult>.Delay(timeout, cts.Token)).ConfigureAwait(false))
                {
                    cts.Cancel();
                    return await task.ConfigureAwait(false);
                }
                else
                {
                    throw new TimeoutException($"Task timed out after {timeout}");
                }
            }
        }

        public static Task<TResult> TimeoutAfter<TResult>(
            this Task<TResult> task,
            int millisecondsTimeout) =>
            task.TimeoutAfter(TimeSpan.FromMilliseconds(millisecondsTimeout));
    }
}
