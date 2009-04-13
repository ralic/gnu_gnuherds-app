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

<h3>{t}FS job offers{/t}</h3>


{include file="offer-type-bar.tpl"}


<p>
{t}Get in contact with some of the best available Free Software experts and their companies. Solve your problems today with the best system administrators, developers, testers, documentalists, etc.{/t}
</p>

{if $smarty.session.Logged neq '1' }

<p>
{t}Are you a Free Software author? You could register and add your qualifications.{/t}
</p>

<p class="center">
<br>
{t escape='no'
  1='<a href="mailto:association@gnuherds.org">association@gnuherds.org</a>'
}The simplest way to post a job offer is to email all the details you have about it to %1{/t}
</p>

<p class="center">
{t}The cost is 0 cents.{/t} &nbsp; {t}The GNU Herds project does not charge for any of its services.{/t}
<br>
<br>
</p>

{else}

<form name="newJobOfferForm" method="post" action="offers?action=edit&amp;id=&amp;section=general" class="center">
<div>
<input type="submit" name="new" value="{t}New job offer{/t}">
</div>
</form>

<br>
<br>
<br>

{/if}


<table border="0">

<tr valign="top">
<td class="tdTitle"><strong>{'Vacancy title'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
<td class="tdTitle"><strong>{'Location'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
<td class="tdTitle"><strong>{'Offer date'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;</strong></td>
<td class="tdTitle"><strong>{'Offered by'|gettext|strip:'&nbsp;'}&nbsp;&nbsp;</strong></td>
<td></td>
<td><a href="offers?format=rss{if $smarty.session.Language neq 'en_US'}&language={$smarty.session.Language}{/if}"><img src="themes/red_Danijel/images/rss.png" alt="RSS"></a></td>
</tr>

{if count($data.JobOffers.JobOfferId) == 0 }
<tr valign="top">
<td colspan="4" class="tdDark center">
{t}There are no active job offers{/t}
</td>
</tr>
{else}

{foreach from=$data.JobOffers.JobOfferId item=Id key=i}

<tr valign="top">

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="offers?id={$Id}">
{$data.JobOffers.VacancyTitle[$i]}
</a>
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if trim($data.JobOffers.City[$i]) eq '' and trim($data.JobOffers.StateProvince[$i]) eq '' and trim($data.JobOffers.CountryName[$i]) eq ''}
<strong>{t domain='database'}Any{/t}</strong>, {t}telework{/t}
{else}
{if trim($data.JobOffers.CountryName[$i]) neq ''}
<strong>{t domain='iso_3166'}{$data.JobOffers.CountryName[$i]}{/t}</strong>{if $data.JobOffers.StateProvince[$i]}, {$data.JobOffers.StateProvince[$i]}{/if}{if $data.JobOffers.City[$i]}, {$data.JobOffers.City[$i]}{/if}
{else}
{if trim($data.JobOffers.StateProvince[$i]) neq ''}
{$data.JobOffers.StateProvince[$i]}{if $data.JobOffers.City[$i]}, {$data.JobOffers.City[$i]}{/if}
{else}
{$data.JobOffers.City[$i]}
{/if}
{/if}
{/if}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$data.JobOffers.OfferDate[$i]}
</td>

<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{if $data.JobOffers.EntityType[$i] eq 'Person'}<strong>{t}Person{/t}</strong>: {/if}
{if $data.JobOffers.EntityType[$i] eq 'Cooperative'}<strong>{t}Cooperative{/t}</strong>: {/if}
{if $data.JobOffers.EntityType[$i] eq 'Company'}<strong>{t}Company{/t}</strong>: {/if}
{if $data.JobOffers.EntityType[$i] eq 'non-profit Organization'}<strong>{t}non-profit Organization{/t}</strong>: {/if}
{if $data.JobOffers.EntityType[$i] eq 'Person' and trim($data.JobOffers.Blog[$i]) neq ''}<a href="{$data.JobOffers.Blog[$i]}">{else}{if trim($data.JobOffers.Website[$i]) neq ''}<a href="{$data.JobOffers.Website[$i]}">{/if}{/if}
{if $data.JobOffers.EntityType[$i] eq 'Person'}{$data.JobOffers.LastName[$i]}{if $data.JobOffers.LastName[$i] and ($data.JobOffers.FirstName[$i] or $data.JobOffers.MiddleName[$i])},{/if} {$data.JobOffers.FirstName[$i]} {$data.JobOffers.MiddleName[$i]}{/if}
{if $data.JobOffers.EntityType[$i] eq 'Cooperative'}{$data.JobOffers.CooperativeName[$i]}{/if}
{if $data.JobOffers.EntityType[$i] eq 'Company'}{$data.JobOffers.CompanyName[$i]}{/if}
{if $data.JobOffers.EntityType[$i] eq 'non-profit Organization'}{$data.JobOffers.OrganizationName[$i]}{/if}
{if ($data.JobOffers.EntityType[$i] eq 'Person' and trim($data.JobOffers.Blog[$i]) neq '') or trim($data.JobOffers.Website[$i]) neq ''}</a>{/if}
</td>

</tr>

{/foreach}

{/if}

</table>
