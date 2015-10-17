
<div class="has_toolbar">
    <h2>{$CONST.MEDIA_LIBRARY}</h2>

    <form id="media_library_control" method="get" action="?">
        {$media.token}
        {$media.form_hidden}
        <ul class="filters_toolbar clearfix plainList">
            <li><a class="button_link" href="#media_pane_filter" title="Show filters"><span class="icon-filter"></span><span class="visuallyhidden"> {$CONST.FILTERS}</span></a></li>
            <li><a class="button_link" href="#media_pane_sort" title="{$CONST.SORT_ORDER}"><span class="icon-sort"></span><span class="visuallyhidden"> {$CONST.SORT_ORDER}</span></a></li>
            <li id="media_filter_path">
                <div class="form_select">
                    <label for="serendipity_only_path" class="visuallyhidden">{$CONST.FILTER_DIRECTORY}</label>
                    <select id="serendipity_only_path" name="serendipity[only_path]">
                        <option value="">{if NOT $media.limit_path}{$CONST.ALL_DIRECTORIES}{else}{$media.blimit_path}{/if}</option>
                    {foreach $media.paths AS $folderHead}

                        <option{if ($media.only_path == $media.limit_path|cat:$folderHead.relpath)} selected{/if} value="{$folderHead.relpath}">{'&nbsp;'|str_repeat:($folderHead.depth*2)}{$folderHead.name}</option>
                    {/foreach}

                    </select>
                    <input name="go" type="submit" value="{$CONST.GO}">
                </div>
            </li>
            <li id="media_selector_bar">
                <fieldset>
                    <input id="serendipity[filter][fileCategory][All]" type="radio" name="serendipity[filter][fileCategory]"{if $media.filter.fileCategory == ""} checked{/if} value="">
                    <label for="serendipity[filter][fileCategory][All]" class="media_selector button_link">{$CONST.COMMENTS_FILTER_ALL}</label>
                    <input id="serendipity[filter][fileCategory][Image]" type="radio" name="serendipity[filter][fileCategory]"{if $media.filter.fileCategory == "image"} checked{/if} value="image">
                    <label for="serendipity[filter][fileCategory][Image]" class="media_selector button_link">{$CONST.IMAGE}</label>
                    <input id="serendipity[filter][fileCategory][Video]" type="radio" name="serendipity[filter][fileCategory]"{if $media.filter.fileCategory == "video"} checked{/if} value="video">
                    <label for="serendipity[filter][fileCategory][Video]" class="media_selector button_link">{$CONST.VIDEO}</label>
                </fieldset>
            </li>
            <li id="media_dir_radio" class="media_select_strict">
                <div class="clearfix">
                    <div class="form_radio">
                        <input id="radio_link_no" name="serendipity[toggle_dir]" type="radio" value="no" {'toggle_dir'|ifRemember:'no'}>
                        <label for="radio_link_no">Strict {$CONST.NO}</label>
                    </div>

                    <div class="form_radio">
                        <input id="radio_link_yes" name="serendipity[toggle_dir]" type="radio" value="yes" {'toggle_dir'|ifRemember:'yes':true}>
                        <label for="radio_link_yes">Strict {$CONST.YES}</label>
                    </div>
                </div>
            </li>
        </ul>

        <fieldset id="media_pane_filter" class="additional_info filter_pane">
            <legend class="visuallyhidden">{$CONST.FILTERS}</legend>
{* Keep in mind that $media.sort_order is different than $media.sortorder! The first is for building the key names; the second is the value that was set by POST! *}
            <div id="media_filter" class="clearfix">
            {foreach $media.sort_order AS $filter}

                <div class="{cycle values="left,center,right"}">
                {if $filter.type == 'date' || $filter.type == 'intrange'}

                    <fieldset>
                        <span class="wrap_legend"><legend>{$CONST.SORT_BY} ({$filter@key})</legend></span>
                {else}

                    <div class="form_{if $filter.type == 'authors'}select{else}field{/if}">
                        <label for="serendipity_filter_{$filter@key}">{$filter.desc}</label>
                {/if}
                {if $filter.type == 'date'}

                        <div class="form_field">
                            <label for="serendipity_filter_{$filter@key}_from" class="visuallyhidden">{$CONST.RANGE_FROM}</label>
                            <input id="serendipity_filter_{$filter@key}_from" name="serendipity[filter][{$filter@key}][from]" type="date" value="{$media.filter[$filter@key].from|escape}">
                            -
                            <label for="serendipity_filter_{$filter@key}_to" class="visuallyhidden">{$CONST.RANGE_TO}</label>
                            <input id="serendipity_filter_{$filter@key}_to" name="serendipity[filter][{$filter@key}][to]" type="date" value="{$media.filter[$filter@key].to|escape}">
                        </div>
                {elseif $filter.type == 'intrange'}

                        <div class="form_field">
                            <label for="serendipity_filter_{$filter@key}_from" class="visuallyhidden">{$CONST.RANGE_FROM}</label>
                            <input id="serendipity_filter_{$filter@key}_from" name="serendipity[filter][{$filter@key}][from]" type="text" value="{$media.filter[$filter@key].from|escape}">
                            -
                            <label for="serendipity_filter_{$filter@key}_to" class="visuallyhidden">{$CONST.RANGE_TO}</label>
                            <input id="serendipity_filter_{$filter@key}_to" name="serendipity[filter][{$filter@key}][to]" type="text" value="{$media.filter[$filter@key].to|escape}">
                        </div>
                {elseif $filter.type == 'authors'}

                        <select id="serendipity_filter_{$filter@key}" name="serendipity[filter][{$filter@key}]">
                            <option value="">{$CONST.ALL_AUTHORS}</option>
                            {foreach $media.authors AS $media_author}

                            <option value="{$media_author.authorid}"{if $media.filter[$filter@key] == $media_author.authorid} selected{/if}>{$media_author.realname|escape}</option>
                            {/foreach}

                        </select>
                {else}{* this is type string w/o being named *}
                        {* label is already set on loop start, when type is not date or intrange *}
                        <input id="serendipity_filter_{$filter@key}" name="serendipity[filter][{$filter@key}]" type="text" value="{$media.filter[$filter@key]|escape}">
                {/if}
                {if $filter.type == 'date' || $filter.type == 'intrange'}

                    </fieldset>
                {else}

                    </div>
                {/if}

                </div>{* media filter end *}
            {/foreach}

                <div id="media_filter_file" class="form_field left">
                    <label for="serendipity_only_filename">{$CONST.SORT_ORDER_NAME}</label>
                    <input id="serendipity_only_filename" name="serendipity[only_filename]" type="text" value="{$media.only_filename|escape}">
                </div>

                <div id="media_filter_keywords" class="form_field center">
                    <label for="keyword_input">{$CONST.MEDIA_KEYWORDS}</label>
                    <input id="keyword_input" name="serendipity[keywords]" type="text" value="{$media.keywords_selected|escape}">
                </div>

                <div id="keyword_list" class="clearfix right">
                {foreach $media.keywords AS $keyword}

                    <a class="add_keyword" href="#keyword-input" data-keyword="{$keyword|escape}" title="{$keyword|escape}">{$keyword|escape|truncate:20:"&hellip;"}</a>
                {/foreach}

                </div>
            </div>
        </fieldset>

        <fieldset id="media_pane_sort" class="additional_info filter_pane">
            <legend class="visuallyhidden">{$CONST.SORT_ORDER}</legend>
            <div class="clearfix grouped">
                <div class="form_select">
                    <label for="serendipity_sortorder_order">{$CONST.SORT_BY}</label>
                    {* Keep in mind that $media.sort_order is different than $media.sortorder! *}
                    <select id="serendipity_sortorder_order" name="serendipity[sortorder][order]">
                    {foreach $media.sort_order AS $orderVal}
                        {* The first is for building the key names *}
                        <option value="{$orderVal@key}"{if $media.sortorder.order == $orderVal@key} selected{/if}>{$orderVal.desc}</option>
                    {/foreach}

                    </select>
                </div>

                <div class="form_select">
                    <label for="serendipity_sortorder_ordermode">{$CONST.SORT_ORDER}</label>
                    {* The second is the value that was set by POST or COOKIE! *}
                    <select id="serendipity_sortorder_ordermode" name="serendipity[sortorder][ordermode]">
                        <option value="DESC"{if $media.sortorder.ordermode == 'DESC'} selected{/if}>{$CONST.SORT_ORDER_DESC}</option>
                        <option value="ASC"{if $media.sortorder.ordermode == 'ASC'} selected{/if}>{$CONST.SORT_ORDER_ASC}</option>
                    </select>
                </div>

                <div class="form_select">
                    <label for="serendipity_sortorder_perpage">{$CONST.FILES_PER_PAGE}</label>

                    <select id="serendipity_sortorder_perpage" name="serendipity[sortorder][perpage]">
                    {foreach $media.sort_row_interval AS $perPageVal}

                        <option value="{$perPageVal}"{if $media.perPage == $perPageVal} selected{/if}>{$perPageVal}</option>
                    {/foreach}

                    </select>
                </div>
            </div>

            <div class="form_buttons">
                <input name="go" type="submit" value="{$CONST.GO}">
            </div>
        </fieldset>
        <script>
            $(document).ready(function() {
            {foreach $media.sortParams AS $sortParam}

                serendipity.SetCookie("sortorder_{$sortParam}","{$get_sortorder_{$sortParam}}");
            {/foreach}
            {foreach $media.filterParams AS $filterParam}

                serendipity.SetCookie("{$filterParam}", "{$get_{$filterParam}}");
            {/foreach}

            });
        </script>
    </form>
</div>{* has toolbar end *}

{if $smarty.get.serendipity.showUpload}
<div class="popuplayer_showUpload">
    <a class="button_link" href="?serendipity[adminModule]=media&serendipity[adminAction]=addSelect&{$media.extraParems}">{$CONST.ADD_MEDIA}</a>
</div>
{/if}

<div class="media_library_pane">
{if $media.nr_files < 1}

    <span class="msg_notice"><span class="icon-info-circled"></span> {$CONST.NO_IMAGES_FOUND}</span>
{else}
    {if $media.manage}

    <form id="formMultiDelete" name="formMultiDelete" action="?" method="post">
        {$media.token}
        <input name="serendipity[action]" type="hidden" value="admin">
        <input name="serendipity[adminModule]" type="hidden" value="media">
        <input name="serendipity[adminAction]" type="hidden" value="multidelete">
    {/if}

        <div class="clearfix media_pane" data-thumbmaxwidth="{$media.thumbSize}">
            {$MEDIA_ITEMS}

        {if ($media.page != 1 && $media.page <= $media.pages)||$media.page != $media.pages}

            <nav class="pagination">
                <h3>{$CONST.PAGE_BROWSE_ENTRIES|sprintf:$media.page:$media.pages:$media.totalImages}</h3>

                <ul class="clearfix">
                    <li class="first">{if $media.page > 1}<a class="button_link" href="{$media.linkFirst}" title="{$CONST.FIRST_PAGE}"><span class="visuallyhidden">{$CONST.FIRST_PAGE} </span><span class="icon-to-start"></span></a>{/if}</li>
                    <li class="prev">{if $media.page != 1 AND $media.page <= $media.pages}<a class="button_link" href="{$media.linkPrevious}" title="{$CONST.PREVIOUS}"><span class="icon-left-dir"></span><span class="visuallyhidden"> {$CONST.PREVIOUS}</span></a>{else}<span class="visuallyhidden">{$CONST.NO_ENTRIES_TO_PRINT}</span>{/if}</li>
                    {* Looks weird, but last will be at end by the CSS float:right *}
                    <li class="last">{if $media.page < $media.pages}<a class="button_link" href="{$media.linkLast}" title="{$CONST.LAST_PAGE}"><span class="visuallyhidden">{$CONST.LAST_PAGE} </span><span class="icon-to-end"></span></a>{/if}</li>
                    <li class="next">{if $media.page != $media.pages}<a class="button_link" href="{$media.linkNext}" title="{$CONST.NEXT}"><span class="visuallyhidden">{$CONST.NEXT} </span><span class="icon-right-dir"></span></a>{else}<span class="visuallyhidden">{$CONST.NO_ENTRIES_TO_PRINT}</span>{/if}</li>
                </ul>
            </nav>
        {/if}

        </div>{* media pane end *}

    {if $media.manage}

        <div class="form_buttons">
            <input class="invert_selection" name="toggle" type="button" value="{$CONST.INVERT_SELECTIONS}">
            <input class="state_cancel" name="toggle_delete" type="submit" value="{$CONST.DELETE}">
        </div>
        <hr>
        <div class="form_select">
                <label for="newDir">{$CONST.FILTER_DIRECTORY}</label>
                <input type="hidden" name="serendipity[oldDir]" value="">
                <select id="newDir" name="serendipity[newDir]">
                    <option value=""></option>
                    <option value="uploadRoot">{$CONST.BASE_DIRECTORY}</option>
                {foreach $media.paths AS $folderFoot}

                    <option{if ($media.only_path == $media.limit_path|cat:$folderFoot.relpath)} selected{/if} value="{$folderFoot.relpath}">{'&nbsp;'|str_repeat:($folderFoot.depth*2)}{$folderFoot.name}</option>{***}
                {/foreach}

                </select>
        </div>
        <div class="form_buttons">
            <input class="state_submit" name="toggle_move" type="submit" value="{$CONST.MOVE}">
            <span class="media_file_actions actions"><a class="media_show_info button_link" href="#media_file_bulkmove" title="{$CONST.BULKMOVE_INFO}"><span class="icon-info-circled"></span><span class="visuallyhidden"> {$CONST.BULKMOVE_INFO}</span></a></span>
        </div>

        <footer id="media_file_bulkmove" class="media_file_bulkmove additional_info">
            <span class="msg_notice">{$CONST.BULKMOVE_INFO_DESC}</span>
        </footer>
    {/if}

    </form>
{/if}

</div>{* media library pane end *}
