using Numberskills.Web.Middlewares;

namespace Numberskills.Web.Utils
{
    public static class PipelineExtensions
    {
        public static IApplicationBuilder UseExceptionFormatter(this IApplicationBuilder builder)
        {
            builder.UseMiddleware<ExceptionFormattingMiddleware>();
            return builder;
        }
        
        public static IApplicationBuilder UseRequestLocalizationCookies(this IApplicationBuilder builder)
        {
            builder.UseMiddleware<RequestLocalizationCookiesMiddleware>();
            return builder;
        }
    }
}