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

<form name="dataForm" method="post" action="offers?action=edit&id={$smarty.get.JobOfferId}&section=">

<table>

{if $smarty.get.JobOfferId }
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}Update job offer{/t}</td> </tr>
{else}
<tr align="center"> <td colspan="4" align="center" class="mainsection">{t}New job offer{/t}</td> </tr>
{/if}

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4" align="center">
{include file="Job_Offer_edit-guide-bar.tpl"}
</td>
</tr>

<tr> <td colspan="4">&nbsp;</td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>

{if $checks.result eq 'fail' }
<tr> <td colspan="4" class="footnote"><span class="must">{t}Some fields does not match.{/t} {t}Please try again.{/t}</span></td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>
{elseif $checks.result eq 'suggestions' }
<tr> <td colspan="4" class="footnote"><span class="must">{t}Some fields offer suggestions.{/t} {t}The form has not been saved yet.{/t} {t}Please, choose or edit again.{/t}</span></td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>
{/if}

<tr> <td colspan="4">{t}Non-Free or Pending skills are not showed in the view.{/t}</td> </tr>
<tr> <td colspan="4">&nbsp;</td> </tr>

<tr> <td colspan="4" class="subsection">{t}Technical{/t}</td> </tr>

<tr> <td colspan="4">&nbsp;</td> </tr>

<tr>
<td colspan="4" align="right">

<table>
<tr>
<td>
{if $smarty.post.SkillList|@count >= 1}
<label>{'Mark to delete'|gettext|strip:'&nbsp;'}</label>
{/if}
</td>
<td><label class="raisePopUp" title="{t}Non-Free or Pending skills are not showed in the view.{/t}">{t}Checks{/t}</label></td>
<td><label class="raisePopUp" title="{t}Add skills and theirs knowledge and experience levels.{/t}">{t}Skills{/t}</label></td>
<td>
<label>{'Knowledge level'|gettext|strip:'&nbsp;'}</label>
</td>
<td>
<label>{'Experience level'|gettext|strip:'&nbsp;'}</label>
</td>
</tr>


{foreach from=$smarty.post.SkillList item=Skill key=i}

<tr>
<td align="right">
{if $smarty.post.SkillList|@count >= 1}
<input type="checkbox" name="DeleteSkillList[]" value="{$i}">
{/if}
</td>
<td class="{if $i % 2}greenDark{else}greenLight{/if}">
{if $data.CheckList[$i] eq "Pending"}<label title="{t}This skill is pending for checking.{/t}">{'Pending'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Unknown"}<label title="{t}This skill is unknown.{/t}">{'Unknown'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Abstract"}<label title="{t}This skill is abstract.{/t}">{'Abstract'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Free Software"}<label title="{t}This skill is Free.{/t} {t}Software criteria at the FAQ.{/t} {t}Report any mistake!{/t}">{'Free Software'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Almost-Free Software"}<label title="{t}This skill is almost Free.{/t} {t}Software criteria at the FAQ.{/t} {t}Report any mistake!{/t}">{'Almost-Free Software'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Partially-Free Software"}<label title="{t}This skill is partially Free.{/t} {t}Software criteria at the FAQ.{/t} {t}Report any mistake!{/t}">{'Partially-Free Software'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Non-Free Software"}<label title="{t}This skill is not Free.{/t} {t}Software criteria at the FAQ.{/t} {t}Report any mistake!{/t}">{'Non-Free Software'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Hardware"}<label title="{t}This skill is Hardware.{/t}">{'Hardware'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Documentation"}<label title="{t}This skill is Documentation.{/t}">{'Documentation'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Free Documentation"}<label title="{t}This skill is Free.{/t} {t}Software criteria at the FAQ.{/t} {t}Report any mistake!{/t}">{'Free Documentation'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Non-Free Documentation"}<label title="{t}This skill is not Free.{/t} {t}Software criteria at the FAQ.{/t} {t}Report any mistake!{/t}">{'Non-Free Documentation'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Data"}<label title="{t}This skill is Data.{/t}">{'Data'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Free Data"}<label title="{t}This skill is Free.{/t} {t}Software criteria at the FAQ.{/t} {t}Report any mistake!{/t}">{'Free Data'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Non-Free Data"}<label title="{t}This skill is not Free.{/t} {t}Software criteria at the FAQ.{/t} {t}Report any mistake!{/t}">{'Non-Free Data'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Art"}<label title="{t}This skill is Art.{/t}">{'Art'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Sharable Art"}<label title="{t}This skill is Free.{/t} {t}Software criteria at the FAQ.{/t} {t}Report any mistake!{/t}">{'Sharable Art'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
{if $data.CheckList[$i] eq "Non-Sharable Art"}<label title="{t}This skill is not Free.{/t} {t}Software criteria at the FAQ.{/t} {t}Report any mistake!{/t}">{'Non-Sharable Art'|dgettext:'database'|strip:'&nbsp;'}</label>{/if}
</td>

<td class="{if $i % 2}greenDark{else}greenLight{/if}">
<input type="text" name="SkillList[]" size="40" maxlength="153" class="{if $i % 2}greenDark{else}greenLight{/if}" value="{$smarty.post.SkillList[$i]}">
<input type="hidden" name="ShadowSkillList[]" value="{$smarty.post.ShadowSkillList[$i]}">
<input type="hidden" name="SkillsToInsert[]" value="{$smarty.post.SkillsToInsert[$i]}">
<input type="hidden" name="SuggestionShadow[]" value="{$smarty.post.SkillList[$i]}">

{if count($smarty.post.SuggestedSkills[$i]) >= 1 }
<br>
<span class="must">{t}Please choose:{/t}<br></span>
{html_radios name='SuggestionSet'|cat:$i options=$smarty.post.SuggestedSkills[$i] separator='<br>'}
<label><input type="radio" name="SuggestionSet{$i}" value="Keep as is" />{t}Keep as is{/t}</label><br />
{/if}

{if $checks.SkillList[$i] neq '' }
<br>
<span class="must">{$checks.SkillList[$i]}</span>
{/if}

</td>

<td class="{if $i % 2}greenDark{else}greenLight{/if}">
<select name="SkillKnowledgeLevelList[]" class="{if $i % 2}greenDark{else}greenLight{/if}">
{html_options values=$skillKnowledgeLevelsId output=$skillKnowledgeLevelsName selected=$smarty.post.SkillKnowledgeLevelList[$i]}
</select>
{if $checks.SkillKnowledgeLevelList[$i] neq '' }
<br>
<span class="must">{$checks.SkillKnowledgeLevelList[$i]}</span>
{/if}
</td>

<td class="{if $i % 2}greenDark{else}greenLight{/if}">
<select name="SkillExperienceLevelList[]" class="{if $i % 2}greenDark{else}greenLight{/if}">
{html_options values=$skillExperienceLevelsId output=$skillExperienceLevelsName selected=$smarty.post.SkillExperienceLevelList[$i]}
</select>
{if $checks.SkillExperienceLevelList[$i] neq '' }
<br>
<span class="must">{$checks.SkillExperienceLevelList[$i]}</span>
{/if}
</td>
</tr>

{/foreach}


{if $checkresults.skills eq 'pass' or $smarty.post.SkillList|@count < 1 }

<tr valign="top">
<td>
</td>
<td>
</td>

<td>
<input type="text" name="SkillList[]" size="40" maxlength="153" class="notRequired" value="">
</td>

<td>
<select name="SkillKnowledgeLevelList[]" class="notRequired">
{html_options values=$skillKnowledgeLevelsId output=$skillKnowledgeLevelsName}
</select>
</td>

<td>
<select name="SkillExperienceLevelList[]" class="notRequired">
{html_options values=$skillExperienceLevelsId output=$skillExperienceLevelsName}
</select>
</td>
</tr>

{/if}


<tr>
<td colspan="5" align="right">
<input type="submit" name="more" value="{t}More{/t}" title="{t}Save and or delete and stay here to add more{/t}">
</td>
</tr>
</table>

</td>
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

<input type="hidden" name="jump2previous" value="profiles_etc">
<input type="hidden" name="jump2next" value="languages">

&nbsp; &nbsp; &nbsp;

<input type="submit" name="finish" value="{t}Finish{/t}" title="{t}Save and finish the edition{/t}" {if $checkresults.general neq 'pass' or $checkresults.profiles_etc neq 'pass' or $checkresults.languages neq 'pass' or $checkresults.projects neq 'pass' or $checkresults.location neq 'pass' or $checkresults.contract neq 'pass'}disabled{/if}>
</td>
</tr>

</table>

</form>

