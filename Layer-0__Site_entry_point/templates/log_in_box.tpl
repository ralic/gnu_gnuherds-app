{*
Authors: Davi Leal

Copyright (C) 2002, 2003, 2004, 2005, 2006 Davi Leal <davi at leals dot com>

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

<form name="LogForm" method="post" action="{if not isset($smarty.server.HTTPS) || $smarty.server.HTTPS neq 'on' }http://{else}https://{/if}{$smarty.server.HTTP_HOST}{$smarty.server.REQUEST_URI}">

<!-- These are the post values which we must pass through at this page. -->
<input type="hidden" name="JobOfferId" value="{$smarty.post.JobOfferId}">
<input type="hidden" name="ViewEntityId" value="{$smarty.post.ViewEntityId}">
<input type="hidden" name="ViewJobOfferId" value="{$smarty.post.ViewJobOfferId}">
<input type="hidden" name="SearchWordsInFullTextQualifications" value="{$smarty.post.SearchWordsInFullTextQualifications}">

<table border="0" cellspacing="0" cellpadding="2" bgcolor="{$webpage->theme->loginBoxBGcolor}">
<tr>
<td colspan="2" align="center" class="login"><u>{'Manage your data'|gettext|strip:'&nbsp;'}</u><br><br></td>
</tr>

<tr>
<td nowrap align="right" class="login">
E-mail:<br>
<br>
{'Password'|gettext}:<br>
<br>
</td>
<td nowrap>
<input type="text" name="Email" size="6"> <br>
<input type="password" name="Password" size="6"><br>
<br>
</td>
</tr>

<tr>
<td colspan="2" align="center">
<input type="submit" name="login" value="{'Log in'|gettext}">
</td>
</tr>

<tr>
<td colspan="2" align="center" class="login">
<a href="https://{$smarty.server.HTTP_HOST}/Lost_Password.php" target="_top">{'Lost password?'|gettext|strip:'&nbsp;'}</a><br>
<br>
<a href="https://{$smarty.server.HTTP_HOST}/Person.php" target="_top">{'New person?'|gettext}</a><br>
<a href="https://{$smarty.server.HTTP_HOST}/Company.php" target="_top">{'New company?'|gettext}</a><br>
<a href="https://{$smarty.server.HTTP_HOST}/non-profit_Organization.php" target="_top">{'New non-profit?'|gettext}</a>
</td>
</tr>
</table>
</form>
