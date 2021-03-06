{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2006, 2007, 2008, 2009 Davi Leal <davi at leals dot com>
              2007, 2008, 2009 Victor Engmark <victor dot engmark at gmail dot com>

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero
General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this
program in the COPYING file.  If not, see <http://www.gnu.org/licenses/>.
*}

<table cellpadding="0" rules="none" border="0">

{if $smarty.get.EntityId eq $smarty.session.EntityId and $data.CompletedEdition eq 'f' }
	<tr align="center">
	<td colspan="5" align="center"><span class="modification">{t}The edition of these qualifications is not finished! It does not comply the minimum requisites to allow it subscribe to offers.{/t}</span></td>
	</tr>

	<tr> <td colspan="5">&nbsp;</td> </tr> 
	<tr> <td colspan="5">&nbsp;</td> </tr> 
{/if}

<tr valign="top">
{if $data.PhotoOrLogo eq 'true' }
<td><img src="photo?acl=resume&amp;id={$smarty.get.EntityId}" alt="{t}Photo or logo{/t}" class="frame"></td>
{/if}
<td colspan="3">

{t}{$data.EntityType}{/t}:

{if $data.EntityType eq 'Person' }
	<strong>{$data.LastName}{if trim($data.LastName) and (trim($data.FirstName) or trim($data.MiddleName))},{/if} {$data.FirstName} {$data.MiddleName}</strong><br>

	{if trim($data.BirthYear) neq ''}
		{t}Born{/t}: <strong>{$data.BirthYear}</strong><br>
	{/if}
{/if}

{if $data.EntityType eq 'Cooperative' and trim($data.CooperativeName) neq ''}
	<strong>{$data.CooperativeName}</strong><br>
{/if}

{if $data.EntityType eq 'Company' and trim($data.CompanyName) neq ''}
	<strong>{$data.CompanyName}</strong><br>
{/if}

{if $data.EntityType eq 'non-profit Organization' and trim($data.NonprofitName) neq ''}
	<strong>{$data.NonprofitName}</strong><br>
{/if}

{if count($data.NationalityNameList) > 0 }
	{if count($data.NationalityNameList) == 1 }
		{t}Nationality{/t}: <strong>{$data.NationalityNameList[0]}</strong><br>
	{else}
		{t}Nationalities{/t}:
		{foreach from=$data.NationalityNameList item=profile key=i}{if $i == 0}<strong>{$data.NationalityNameList[$i]}</strong>{else}, <strong>{$data.NationalityNameList[$i]}</strong>{/if}{/foreach}<br>
	{/if}
{/if}

{if count($data.JobLicenseAtCountryNameList) > 0 }
	{t}Besides license to work at{/t}:
	{if count($data.JobLicenseAtCountryNameList) == 1 }
		<strong>{t}{$data.JobLicenseAtCountryNameList[0]}{/t}</strong><br>
	{else}
		{foreach from=$data.JobLicenseAtCountryNameList item=profile key=i}{if $i == 0}<strong>{t}{$data.JobLicenseAtCountryNameList[$i]}{/t}</strong>{else}, <strong>{t}{$data.JobLicenseAtCountryNameList[$i]}{/t}</strong>{/if}{/foreach}<br>
	{/if}
{/if}

<br>

{* Postal address *}

{if trim($data.Street) neq '' or trim($data.Suite) neq ''}
	{$data.Street}{if trim($data.Street) neq '' and trim($data.Suite) neq ''}, {/if}
	{$data.Suite}
	<br>
{/if}

{if trim($data.PostalCode) neq '' or  trim($data.City) neq ''}
	{$data.PostalCode}
	{if trim($data.PostalCode) neq '' and trim($data.City) neq ''} - {/if}
	{$data.City}
	<br>
{/if}

{if trim($data.StateProvince) neq '' or trim($data.CountryName) neq ''}
	{$data.StateProvince}{if trim($data.StateProvince) neq '' and trim($data.CountryName) neq ''}, {/if}
	{if trim($data.CountryName) neq ''}<strong>{t domain='iso_3166'}{$data.CountryName}{/t}</strong>{/if}
	<br>
{/if}

<br>

{* Other contact information *}

{t}Email{/t}: {mailto address=$data.Email}<br>

{if trim($data.Blog) neq ''}
	{t}Blog{/t}: <a href="{$data.Blog}">{$data.Blog}</a><br>
{/if}

{if trim($data.Website) neq ''}
	{t}Web site{/t}: <a href="{$data.Website}">{$data.Website}</a><br>
{/if}


<br>

{if trim($data.Landline) neq ''}
	<strong>{t}Landline{/t}</strong>: {$data.Landline}<br>
{/if}

{if trim($data.MobilePhone) neq ''}
	<strong>{t}Mobile phone{/t}</strong>: {$data.MobilePhone}<br>
{/if}

{if trim($data.IpPhoneOrVideo) neq ''}
	<strong>{t}IP phone or videophone{/t}</strong>: {$data.IpPhoneOrVideo}<br>
{/if}

</td>

{if $data.PhotoOrLogo neq 'true' }
<td>&nbsp;</td>
{/if}

{if $smarty.get.EntityId eq $smarty.session.EntityId}

{if $smarty.session.LoginType eq 'Person' }
	{assign var="Entity" value="person"}
{/if}
{if $smarty.session.LoginType eq 'Cooperative' }
	{assign var="Entity" value="cooperative"}
{/if}
{if $smarty.session.LoginType eq 'Company' }
	{assign var="Entity" value="company"}
{/if}
{if $smarty.session.LoginType eq 'non-profit Organization' }
	{assign var="Entity" value="nonprofit"}
{/if}

<td class="edit"><a href="{$Entity}" title="{t}Edit section{/t}: {t}{$data.EntityType}{/t}">{t}edit{/t}</a></td>

{/if}

</tr>


{if $data.EntityType neq 'Person' }

<tr>
<td colspan="4">&nbsp;</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4">{t}Staff with the below characteristic:{/t}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

{/if}

<tr>
<td colspan="4">&nbsp;</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4" class="subsection">{t}Technical{/t}</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=profiles_etc" title="{t}Edit section{/t}: {t}Technical{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{'Professional experience since'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenLight">{$data.ProfessionalExperienceSinceYear}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=profiles_etc" title="{t}Edit section{/t}: {t}Professional experience since{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr valign="top">
<td align="right"><strong>{t}Profiles{/t}</strong> : </td>

<td class="greenDark"><span class="u">{'Product profiles'|gettext|strip:'&nbsp;'}</span><br>
{if not is_array($data.ProductProfileList) or count($data.ProductProfileList) == 0}
	{'not specified'|gettext|strip:'&nbsp;'}
{else}
	{foreach from=$data.ProductProfileList item=profile}
		{$profile|dgettext:'database'|strip:'&nbsp;'}<br>
	{/foreach}
{/if}
</td>

<td class="greenDark"><span class="u">{'Professional profiles'|gettext|strip:'&nbsp;'}</span><br>
{if not is_array($data.ProfessionalProfileList) or count($data.ProfessionalProfileList) == 0}
	{'not specified'|gettext|strip:'&nbsp;'}
{else}
	{foreach from=$data.ProfessionalProfileList item=profile}
		{$profile|dgettext:'database'|strip:'&nbsp;'}<br>
	{/foreach}
{/if}
</td>

<td class="greenDark"><span class="u">{'Field profiles'|gettext|strip:'&nbsp;'}</span><br>
{if not is_array($data.FieldProfileList) or count($data.FieldProfileList) == 0}
	{'not specified'|gettext|strip:'&nbsp;'}
{else}
	{foreach from=$data.FieldProfileList item=profile}
		{$profile|dgettext:'database'|strip:'&nbsp;'}<br>
	{/foreach}
{/if}
</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=profiles_etc" title="{t}Edit section{/t}: {t}Profiles{/t}">{t}edit{/t}</a></td>
{/if}

</tr>

<tr valign="top">
<td align="right"><strong>{t}Academic qualification{/t}</strong> : </td>
<td colspan="3" class="greenLight">
{if count($data.DegreeList)>0}
	{foreach from=$data.DegreeList item=degree key=i}
		{if $data.DegreeList[$i]}{$data.DegreeList[$i]} &nbsp; {/if} {if $data.StartDateList[$i] or $data.FinishDateList[$i]}{$data.StartDateList[$i]} &nbsp; {$data.FinishDateList[$i]}{/if} {if $data.DegreeList[$i] or $data.StartDateList[$i] or $data.FinishDateList[$i] or $data.DegreeGrantedList[$i] eq 'No'}<br>{/if}
		{if $data.AcademicLevelList[$i]}{t domain='database'}{$data.AcademicLevelList[$i]}{/t} &nbsp; {if $data.DegreeGrantedList[$i] eq 'No'}<i>{t}Degree not granted{/t}</i>{/if} <br>{/if}
		{if $data.InstitutionList[$i]}{if $data.InstitutionURIList[$i]}<a href="{$data.InstitutionURIList[$i]}">{/if}{$data.InstitutionList[$i]}{if $data.InstitutionURIList[$i]}</a>{/if}<br>{/if}
		{if $data.ShortCommentList[$i]}{$data.ShortCommentList[$i]}<br>{/if}
		<br>
	{/foreach}
{else}
	{t}none{/t}
{/if}
</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=academic" title="{t}Edit section{/t}: {t}Academic qualification{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr valign="top">
<td align="right"><strong>{t}Skills{/t}</strong> : </td>

{if not is_array($data.SkillList) or count($data.SkillList) == 0}
	<td class="greenDark">{t}none{/t}</td> <td class="greenDark"></td> <td class="greenDark"></td>
{else}
<td class="greenDark"><span class="u">{t}Skill{/t}</span><br>
{foreach from=$data.SkillList item=skill}
	{$skill|strip:'&nbsp;'}<br>
{/foreach}
</td>

<td class="greenDark"><span class="u">{'Knowledge level'|gettext|strip:'&nbsp;'}</span><br>
{foreach from=$data.KnowledgeLevelList item=knowledgeLevel}
	{$knowledgeLevel|dgettext:'database'|strip:'&nbsp;'}<br>
{/foreach}
</td>

<td class="greenDark"><span class="u">{'Experience level'|gettext|strip:'&nbsp;'}</span><br>
{foreach from=$data.ExperienceLevelList item=experienceLevel}
	{$experienceLevel|dgettext:'database'|strip:'&nbsp;'}<br>
{/foreach}
</td>

{/if}

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=skills" title="{t}Edit section{/t}: {t}Skills{/t}">{t}edit{/t}</a></td>
{/if}

</tr>

<tr valign="top">
<td align="right"><strong>{t}Languages{/t}</strong> : </td>

<td class="greenLight"><span class="u">{t}Language{/t}</span><br>
{foreach from=$data.LanguageList item=language}
	{$language|dgettext:'iso_639'|strip:'&nbsp;'}<br>
{/foreach}
</td>

<td class="greenLight"><span class="u">{'Spoken level'|gettext|strip:'&nbsp;'}</span><br>
{foreach from=$data.LanguageSpokenLevelList item=spokenLevel}
	{$spokenLevel|dgettext:'database'|strip:'&nbsp;'}<br>
{/foreach}
</td>

<td class="greenLight"><span class="u">{'Written level'|gettext|strip:'&nbsp;'}</span><br>
{foreach from=$data.LanguageWrittenLevelList item=writtenLevel}
	{$writtenLevel|dgettext:'database'|strip:'&nbsp;'}<br>
{/foreach}
</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=languages" title="{t}Edit section{/t}: {t}Languages{/t}">{t}edit{/t}</a></td>
{/if}

</tr>

{* The certifications feature is disabled
<tr valign="top">
<td align="right"><strong>{t}Certifications{/t}</strong> : <br> </td>
<td colspan="3" class="greenDark">
{if is_array($data.CertificationsList) and count($data.CertificationsList) > 0}
	{foreach from=$data.CertificationsList item=certification key=i}
		{if $data.CertificationsStateList[$i] eq 'Accepted'}
			{$certification}<br>
			{assign var="HasSomeCertification" value="Yes"}
		{/if}
	{/foreach}
{/if}
{if $HasSomeCertification neq 'Yes'}
	{t}none{/t}
{/if}
</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=certifications" title="{t}Edit section{/t}: {t}Certifications{/t}">{t}edit{/t}</a></td>
{/if}

</tr>
*}

<tr valign="top">
<td align="right"><strong>{'Contributions to FS projects'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenDark">
{if is_array($data.ContributionsListProject) and count($data.ContributionsListProject) > 0 }
	{foreach from=$data.ContributionsListProject item=project key=i}
		<a href="{$data.ContributionsListURI[$i]}">{$project}</a>{if $data.ContributionsListDescription[$i] neq ''}: {$data.ContributionsListDescription[$i]}{/if}<br>
	{/foreach}
{else}
	{t}none{/t}
{/if}
</td>

{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=projects" title="{t}Edit section{/t}: {t}Contributions to FS projects{/t}">{t}edit{/t}</a></td>
{/if}

</tr>

{if $data.EntityType eq 'Person' }

<tr>
<td colspan="4">&nbsp;</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4" class="subsection">{t}Contract{/t}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=contract" title="{t}Edit section{/t}: {t}Contract{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{t}Desired contract type{/t}</strong> : </td>
<td colspan="3" class="greenLight">{if $data.DesiredContractType neq ''}{t domain='database'}{$data.DesiredContractType}{/t}{/if}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{t}Desired wage rank{/t}</strong> : </td>
<td colspan="3" class="greenDark">
{$data.DesiredWageRank}
{if $data.WageRankCurrencyName neq ''}({t domain='iso_4217'}{$data.WageRankCurrencyName}{/t}){/if}
{if $data.WageRankByPeriod neq ''} {t domain='database'}{$data.WageRankByPeriod}{/t}. [{t}Minimum{/t}-{t}Optimum{/t}]{/if}
</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr>
<td align="right"><strong>{t}Current employability{/t}</strong> : </td>
<td colspan="3" class="greenLight">{if $data.CurrentEmployability neq ''}{t domain='database'}{$data.CurrentEmployability}{/t}{/if}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

{/if}

<tr>
<td colspan="4">&nbsp;</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr> 

<tr>
<td colspan="4" class="subsection">{t}Location{/t}</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"><a href="/resume?action=edit&amp;id={$smarty.get.EntityId}&amp;section=location" title="{t}Edit section{/t}: {t}Location{/t}">{t}edit{/t}</a></td>
{/if}
</tr>

<tr valign="top">
<td align="right"><strong>{t}Available to travel{/t}</strong> : </td>
<td colspan="3" class="greenDark">
{if $data.AvailableToTravel eq 'false'}
{t}No{/t}
{else}
{t}Yes{/t}
{/if}
</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>

<tr valign="top">
<td align="right"><strong>{'Available to change residence'|gettext|strip:'&nbsp;'}</strong>&nbsp;: </td>
<td colspan="3" class="greenLight">
{if $data.AvailableToChangeResidence eq 'false'}
{t}No{/t}
{else}
{t}Yes{/t}
{/if}
</td>
{if $smarty.get.EntityId eq $smarty.session.EntityId}
<td class="edit"></td>
{/if}
</tr>


{if $smarty.get.EntityId eq $smarty.session.EntityId }
		<tr> <td colspan="5">&nbsp;</td> </tr> 
		<tr> <td colspan="5">&nbsp;</td> </tr> 

		<tr align="center">
		<td colspan="5" align="center">
		<form name="deleteQualificationsForm" method="post" action="resume?id={$smarty.get.EntityId}">
		<div><input type="submit" name="delete" value="{t}Delete qualifications{/t}" title="{t}Delete qualifications from the data base{/t}"></div>
		</form>
		</td>
		</tr>
{/if}

</table>
