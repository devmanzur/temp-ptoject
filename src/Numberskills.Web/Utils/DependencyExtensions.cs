using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.OpenIdConnect;
using Microsoft.AspNetCore.Localization;
using Microsoft.Identity.Web;
using Numberskills.Web.Middlewares;
using Numberskills.Web.Models;

namespace Numberskills.Web.Utils;

public static class DependencyExtensions
{
    public static void AddMicrosoftIdentity(this IServiceCollection services, IConfiguration configuration)
    {
        services.Configure<CookiePolicyOptions>(options =>
        {
            options.CheckConsentNeeded = context => true;
            options.MinimumSameSitePolicy = SameSiteMode.None;
        });
        services.AddSession(options =>
        {
            options.IdleTimeout = TimeSpan.FromMinutes(120);
            options.Cookie.HttpOnly = true;
            //options.Cookie.SameSite = 0;
            //// Make the session cookie essential
            options.Cookie.IsEssential = true;
        });

        services.AddAuthentication(options =>
            {
                options.DefaultSignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;
                options.DefaultAuthenticateScheme = CookieAuthenticationDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = CookieAuthenticationDefaults.AuthenticationScheme;
            });

    }


    private static MicrosoftIdentityWebAppAuthenticationBuilder AddMicrosoftIdentityWebAppWithCookieEvents(this AuthenticationBuilder builder,
        IConfiguration configuration,
        Action<CookieAuthenticationOptions>? configureCookieAuthenticationOptions,
        string configSectionName = Constants.AzureAd,
        string openIdConnectScheme = OpenIdConnectDefaults.AuthenticationScheme,
        string? cookieScheme = CookieAuthenticationDefaults.AuthenticationScheme,
        bool subscribeToOpenIdConnectMiddlewareDiagnosticsEvents = false,
        string? displayName = null)
    {
        if (configuration == null)
        {
            throw new ArgumentException(null, nameof(configuration));
        }

        if (string.IsNullOrEmpty(configSectionName))
        {
            throw new ArgumentException(null, nameof(configSectionName));
        }

        var configurationSection = configuration.GetSection(configSectionName);
        
        return builder.AddMicrosoftIdentityWebApp(
            options => configurationSection.Bind(options),
            configureCookieAuthenticationOptions);
    }

    public static void AddLocalizationSupport(this IServiceCollection services)
    {
        services.AddScoped<RequestLocalizationCookiesMiddleware>();

        services.AddLocalization();
        services.Configure<RequestLocalizationOptions>(options =>
        {
            options.SetDefaultCulture(SupportedCultures.sv.ToString());
            options.AddSupportedUICultures(SupportedCultures.sv.ToString(),
                SupportedCultures.en.ToString());
            options.FallBackToParentUICultures = true;

            options
                .RequestCultureProviders
                .Remove(typeof(AcceptLanguageHeaderRequestCultureProvider));
        });
    }
}