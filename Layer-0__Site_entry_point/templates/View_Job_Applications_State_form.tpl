{*
Authors: Davi Leal, Victor Engmark

Copyright (C) 2006, 2007 Davi Leal <davi at leals dot com>
              2007 Victor Engmark <victor dot engmark at gmail dot com>

This program is free software; you can redistribute it and/or modify it under
the terms of the Affero General Public License as published by Affero Inc.,
either version 1 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful to the Free
Software community, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the Affero
General Public License for more details.

You should have received a copy of the Affero General Public License with this
software in the ./AfferoGPL file; if not, write to Affero Inc., 510 Third Street,
Suite 225, San Francisco, CA 94107, USA
*}
<h3>{t}Job Applications{/t}</h3>
{if count($jobOfferId) == 0 }
	<p>&nbsp;</p>
	<p>{t}You do not have your application subscribed to any open job offer.{/t}</p>
	<p>&nbsp;</p>
{else}
<table align="center" border="0" width="100%">
<tr valign="top">
<td class="tdTitle"><strong>{'Vacancy title'|gettext|strip:'&nbsp;'}</strong></td>
<td class="tdTitle"><strong>{'Offer date'|gettext|strip:'&nbsp;'}</strong></td>
<td></td>
<td class="tdTitle">{'Subscription state'|gettext|strip:'&nbsp;'}</td>
</tr>
{foreach from=$jobOfferId item=Id key=i}
<tr valign="top">
<td class="{if $i % 2}tdDark{else}tdLight{/if}">
<a href="View_Job_Offer.php?JobOfferId={$Id}">
{$vacancyTitle[$i]}
</a>
</td>
<td class="{if $i % 2}tdDark{else}tdLight{/if}">
{$offerDate[$i]}
</td>
<td></td>
<td class="
{if $state[$i] eq 'Received'}{if $i % 2}tdDark{else}tdLight{/if}{/if}
{if $state[$i] eq 'In process'}blueApplicationState{/if}
{if $state[$i] eq 'Ruled out'}redApplicationState{/if}
{if $state[$i] eq 'Finalist'}almostGreenApplicationState{/if}
{if $state[$i] eq 'Selected'}greenApplicationState{/if}
">
{t}{$state[$i]}{/t}
<!--
'Received'	without color
'In process'	blue
'Ruled out'	red
'Finalist' 	almost green
'Selected'	green
-->
</td>
</tr>
{/foreach}
</table>
{/if}
