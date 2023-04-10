using Statline.Common.Utilities;
using System.Reflection;

namespace System.Windows.Forms
{
    public static class DataGridViewExtensions
    {
        private static PropertyInfo? CachedDoubleBufferedPropertyInfo;

        /// <summary>
        /// Provides ability to enable/disable double-buffered rendering for <see cref="DataGridView"/>.
        /// </summary>
        /// <param name="dgv">An instance of <see cref="DataGridView"/>.</param>
        /// <param name="enabled"><c>true</c> to enable double buffering, <c>false</c> otherwise.</param>
        /// <remarks>
        /// DataGridView can be slow when the platform needs to repaint DataGridView. 
        /// Slow DataGridView rendering can be fixed using so called double buffering. 
        /// It is a technique used to draw a control’s contents to a temporary buffer and 
        /// then copying the whole control image on the screen, which may greatly reduce 
        /// or prevent flickering. Many .NET controls have the public Boolean DoubleBuffered 
        /// property that allows the developer to easily enable double buffering, 
        /// but for some unknown reasons the authors of the .NET Framework decided to hide it 
        /// for DataGridView. This extension method uses reflection "hack" to access
        /// underlying <see cref="Control.DoubleBuffered"/> property.
        /// Based on this article https://10tec.com/articles/why-datagridview-slow.aspx.
        /// (Another approach would be to inherit from the <see cref="DataGridView"/> and have
        /// direct access to the property, but this would require using custom control everywhere).
        /// </remarks>
        public static void SetDoubleBuffering(this DataGridView dgv, bool enabled)
        {
            Check.NotNull(dgv, nameof(dgv));

            // Double buffering can make DGV slow in remote desktop
            if (!SystemInformation.TerminalServerSession)
            {
                EnsureCachedSetter();
                CachedDoubleBufferedPropertyInfo!.SetValue(dgv, enabled);
            }
        }

        private static void EnsureCachedSetter()
        {
            if (CachedDoubleBufferedPropertyInfo is null)
            {
                CachedDoubleBufferedPropertyInfo = typeof(DataGridView).GetProperty(
                    "DoubleBuffered",
                    BindingFlags.Instance | BindingFlags.NonPublic);
            }
        }
    }
}
