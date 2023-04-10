using System;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.Extensions
{
	public static class TaskExtensions
	{
		public static async Task<T> Retry<T>(this Task<T> originalTask, int retryCount, int retryDelay)
		{
			while (true)
			{
				try
				{
					return Task.Run(() => originalTask).GetAwaiter().GetResult();
				}
				catch (Exception ex)
				{
					if (retryCount == 0)
					{
						throw;
					}
					retryCount--;
				}
				Thread.Sleep(retryDelay);
			}
		}
	}
}
