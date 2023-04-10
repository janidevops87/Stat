using Microsoft.Extensions.Caching.Memory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Caching;
using System.Text;
using System.Threading.Tasks;

namespace Stattrac.Reporting.Repository
{
    public static class PasswordResetHelper
    {
        private static ObjectCache cache = System.Runtime.Caching.MemoryCache.Default;

        private static int TokenLength = 12;

        public static void Add(string email, string token)
        {
            CacheItemPolicy cacheItemPolicy = new CacheItemPolicy();
            cacheItemPolicy.SlidingExpiration = TimeSpan.FromMinutes(60);
            if (cache.Get(email) != null)
                cache.Remove(email);
            cache.Set(email, token, cacheItemPolicy);
        }

        public static string Get(string key)
        {
            return cache.Get(key)?.ToString();
        }
        public static void Remove(string key)
        {
            cache.Remove(key);
        }
        public static string GenerateToken()
        {
            Random random = new Random();
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, TokenLength)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }
       
    }
}
