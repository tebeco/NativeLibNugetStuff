using System;
using Corp.Common.Lib;

namespace LibSample
{
    class Program
    {
        static void Main()
        {
            var utility = new Utility();
            Console.WriteLine($"From the sample :{utility.DoStuff(1)}");
        }
    }
}
