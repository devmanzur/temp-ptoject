using System.Security.Claims;
using Microsoft.Graph;
using Numberskills.Web.Models;

namespace Numberskills.Web.Utils;

public static class ClaimsExtensions
{
    public static string? GetClaimValue(this ClaimsPrincipal claimsPrincipal, string claimType)
    {
        return claimsPrincipal.Claims.FirstOrDefault(x => x.Type == claimType)?.Value;
    }

    public static bool HasPermission(this ClaimsPrincipal claimsPrincipal, Permission permission)
    {
        var permissionClaim = claimsPrincipal.Claims.FirstOrDefault(x =>
            x.Type == ApplicationClaimTypes.Permission.ToString() &&
            x.Value == permission.ToString());
        return permissionClaim != null;
    }

    public static bool HasClaim(this ClaimsPrincipal claimsPrincipal, ApplicationClaimTypes claimTypes)
    {
        var requiredClaim = claimsPrincipal.Claims.FirstOrDefault(x => x.Type == claimTypes.ToString() &&
                                                                       x.Value != string.Empty);
        return requiredClaim != null;
    }
    
    public static string? GetIdentityClaimValue(this ClaimsPrincipal claimsPrincipal, string claimType)
    {
        return claimsPrincipal.Identities.FirstOrDefault()?.Claims?.FirstOrDefault(x => x.Type == claimType)?.Value;
    }
}