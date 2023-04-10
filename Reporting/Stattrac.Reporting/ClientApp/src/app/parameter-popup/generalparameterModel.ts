export class GeneralParameterModel {
  //These are only passed to the rdl if a value is selected on the screen
  ReportDateTypeId: number;
  StartDateTime: string;
  StartTime: string;
  EndDateTime: string;
  EndTime: string;
  DisplayMT: string;
  OrganizationID: number;
  SourceCodeName: string;
  CoordinatorID: number;
  LowerAgeLimit: number;
  UpperAgeLimit: number;
  Gender: string;
  SortBy1: string;
  HideIdentifyingInfo: boolean;
  //Report Group is always populated, even if not on the screen
  ReportGroupID: number;
  //parameters reports need, but isn't displayed
  //UserID: number;  --so far, all the reports I looked at don't actually do something with this, will add in if needed
  UserOrgID: number;
  UserDisplayName: string;
  BlockEventLog: boolean;
}
