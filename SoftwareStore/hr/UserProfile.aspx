<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="DeviceManagement.hr.UserProfile" %>

<%@ Register Src="~/hr/Controls/ctPersonalInformation.ascx" TagPrefix="uc1" TagName="ctPersonalInformation" %>
<%@ Register Src="~/hr/Controls/ctEducation.ascx" TagPrefix="uc1" TagName="ctEducation" %>
<%@ Register Src="~/hr/Controls/ctLanguageAbility.ascx" TagPrefix="uc1" TagName="ctLanguageAbility" %>
<%@ Register Src="~/hr/Controls/ctCertification.ascx" TagPrefix="uc1" TagName="ctCertification" %>
<%@ Register Src="~/hr/Controls/ctReward.ascx" TagPrefix="uc1" TagName="ctReward" %>
<%@ Register Src="~/hr/Controls/ctAward.ascx" TagPrefix="uc1" TagName="ctAward" %>

<style>
    .label {
        font-weight: bold !important;
    }

    .select2-container .select2-choice {
        height: 30px !important;
    }

    [disabled="disabled"] {
        background: #f4f4f4 !important;
    }

    td label {
        width: 100%;
    }
</style>

<section id="widget-grid" class="">

    <!-- START ROW -->
    <div class="row">

        <!-- NEW COL START -->
        <article class="col-sm-12 col-md-12 col-lg-12">
            <uc1:ctPersonalInformation runat="server" ID="ctPersonalInformation" />
            <uc1:ctEducation runat="server" ID="ctEducation" />
            <uc1:ctLanguageAbility runat="server" ID="ctLanguageAbility" />
            <uc1:ctCertification runat="server" ID="ctCertification" />
            <uc1:ctAward runat="server" ID="ctAward" />
            <uc1:ctReward runat="server" ID="ctReward" />
        </article>
    </div>

</section>

<div class="modal fade" id="remoteModal" role="dialog" aria-labelledby="remoteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content"></div>
    </div>
</div>
<link href="/css/common.css" rel="stylesheet" />
<script type="text/javascript">

    pageSetUp();
    var UserProfilePage = {
        AllowEdit: false,
        TypeAward: null,
        LoadData: function () {
            AJAXFunction.CallAjax("POST", "/hr/UserProfile.aspx", "LoadDataPage", {
                currentuser: GetQueryStringHash("user")
            }, function (response) {
                UserProfilePage.AllowEdit = response.AllowEdit;
                Education.ShowData(response.Data.Education);
                Language.ShowData(response.Data.Language);
                Certification.ShowData(response.Data.Certification);
                Award.ShowData(response.Data.Award);
                Reward.ShowData(response.Data.Reward);
            });
        }
    };
    $(document).ready(function () {
        
        UserProfilePage.LoadData();
    });
</script>
