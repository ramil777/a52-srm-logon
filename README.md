# A52 SRM logon customization

Local SAP NWDS projects based on the standard A52 logon UI WAR.

- `a52-logon-clean`: web project; Java 8; original SAP login UI with explicit imports for IDE validation.
- `A52LogonCleanEAR`: EAR 1.4 project containing the web module.

External compile-time API libraries must be configured locally under `libs/`; they are not included in this repository. Eclipse workspace metadata and build output are excluded. The original `ui_core.jar` from the imported WAR is retained.

## Current checkpoint

Eclipse reported 0 errors and 584 warnings. This is not a confirmation of SAP JSP compilation or successful deployment. SAP application dependency/provider configuration is still pending review. The proposed descriptor change has not been applied. No deployment or UME change is performed by this repository.

Keep each approved change as a separate commit. Build and inspect the exported EAR before deployment. Never commit credentials or private keys.
