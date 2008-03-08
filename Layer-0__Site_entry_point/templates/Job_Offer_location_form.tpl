{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
              2007 Victor Engmark <victor dot engmark at gmail dot com>

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

<form name="dataForm" method="post" action="offers?action=edit&id={$smarty.get.JobOfferId}">

<table>

{if $smarty.get.JobOfferId }
<tr> <td colspan="4" align="center" class="mainsection">{t}Update job offer{/t}</td> </tr>
{else}
<tr> <td colspan="4" align="center" class="mainsection">{t}New job offer{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4" align="center">
{include file="Job_Offer_edit-guide-bar.tpl"}
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4">{t}Do not fill any address field if the offer is Telecommute.{/t}</td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}Residence location{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td align="right"><label for="City">{t}City{/t}</label></td>
<td colspan="3"> <input type="text" name="City" id="City" size="30" maxlength="30" value="{$data.City}" class="notRequired"> </td>
</tr>
<tr>
<td align="right"><label for="StateProvince">{t}State / Province{/t}</label></td>
<td colspan="3"> <input type="text" name="StateProvince" id="StateProvince" size="30" maxlength="30" value="{$data.StateProvince}" class="notRequired"> </td>
</tr>
<tr>
<td align="right"><label for="CountryCode">{t}Country{/t}</label></td>
<td colspan="3">
<select name="CountryCode" id="CountryCode" class="notRequired">
{html_options values=$countryTwoLetter output=$countryNames selected=$data.CountryCode}
</select>
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr valign="top">
<td align="right"> <label for="AvailableToTravel">{t}Available to travel{/t}</label> </td>
<td colspan="3"> <input type="checkbox" name="AvailableToTravel" id="AvailableToTravel" class="notRequired" {if $data.AvailableToTravel eq 'true'} checked {/if} > </td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr> 

<tr> <td colspan="4" class="subsection">&nbsp;</td> </tr>

<tr align="right">
<td colspan="4">
{if $smarty.session.JobOfferId neq ''}
<a href="offers?id={$smarty.session.JobOfferId}">{t}Check offer view{/t}</a>
{/if}

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

<input type="submit" name="previous" value="{t}Previous{/t}" title="{t}Save and move to the previous section{/t}">
<input type="submit" name="next" value="{t}Next{/t}" title="{t}Save and move to the next section{/t}">

<input type="hidden" name="section2control" value="{$section}">

<input type="hidden" name="jump2previous" value="projects">
<input type="hidden" name="jump2next" value="contract">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="{t}Save and finish the edition{/t}" {if $checkresults.general neq 'pass' or $checkresults.profiles_etc neq 'pass' or $checkresults.skills neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or $checkresults.contract neq 'pass'}disabled{/if}>
</td>
</tr>

</table>

</form>

