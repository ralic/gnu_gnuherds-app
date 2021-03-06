{*
Authors: Davi Leal

Copyright (C) 2007, 2008, 2009 Davi Leal <davi at leals dot com>

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

<ul>
<li><a href="/about/">{t}About GNU Herds{/t}</a></li>
<li><a href="/charter/">{t}Charter (draft){/t}</a></li>
<li><a href="/development/">{t}Coders' guide{/t}</a></li>
<li><a href="/faq/">{t}FAQ{/t}</a></li>
<li><a href="/offers/">{t}FS job offers{/t}</a></li>
<li><a href="/pledges/">{t}FS pledges{/t}</a></li>
<li><a href="/volunteers/">{t}FS volunteers{/t}</a></li>
<li><a href="/business_models/">{t}FS business models{/t}</a></li>
</ul>

<p>{t escape='no'
  1='<a href="mailto:association@gnuherds.org">association@gnuherds.org</a>'
}Please send any feedback to %1. For example, you may send reports of technical problems such as broken links, bad page rendering, etc. We would also welcome any criticisms or suggestions. GNU Herds works for you!{/t}
</p>
<div id="agpl-logo">
<a href="http://www.fsf.org/licensing/licenses/agpl-3.0.html"><img src="themes/red_Danijel/images/agplv3-88x31.png" alt="GNU Affero GPL v3"></a>
<a href="gnuherds-online.tar.gz">
{'Download the source code!'|gettext|strip:'&nbsp;'}
</a>
</div>

<div id="locale">
<ul>
{assign var='cleanURI' value=$smarty.server.REQUEST_URI|regex_replace:"/.language=.._../":""}

{if strpos($cleanURI,"?") !== false}
	{assign var='startParameter' value='&amp;'}
{else}
	{assign var='startParameter' value='?'}
{/if}

{* {if $smarty.session.Language eq 'de_DE'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=de_DE" lang="de_DE" hreflang="de_DE" title="{t}Change language{/t}">Deutsch</a></li> *}
{if $smarty.session.Language eq 'en_US'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=en_US" lang="en_US" hreflang="en_US" title="{t}Change language{/t}">English</a></li>
{if $smarty.session.Language eq 'es_ES'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=es_ES" lang="es_ES" hreflang="es_ES" title="{t}Change language{/t}">Español</a></li>
{if $smarty.session.Language eq 'fr_FR'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=fr_FR" lang="fr_FR" hreflang="fr_FR" title="{t}Change language{/t}">Français</a></li>
{if $smarty.session.Language eq 'it_IT'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=it_IT" lang="it_IT" hreflang="it_IT" title="{t}Change language{/t}">Italiano</a></li>
{if $smarty.session.Language eq 'pl_PL'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=pl_PL" lang="pl_PL" hreflang="pl_PL" title="{t}Change language{/t}">Polski</a></li>
{if $smarty.session.Language eq 'pt_PT'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=pt_PT" lang="pt_PT" hreflang="pt_PT" title="{t}Change language{/t}">Português</a></li>
{if $smarty.session.Language eq 'ru_RU'}<li id="lang_active">{else}<li>{/if}<a href="{$cleanURI}{$startParameter}language=ru_RU" lang="ru_RU" hreflang="ru_RU" title="{t}Change language{/t}">Русский</a></li>
</ul>
</div>
