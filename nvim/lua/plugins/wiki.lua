return {
    {
        'm-pilia/vim-mediawiki',
        config = function()
            vim.g.vim_mediawiki_site = 'milwiki.cbrxyz.com'
        end,
    },
    {
        'aquach/vim-mediawiki-editor',
        config = function()
            vim.g.mediawiki_editor_url = 'milwiki.cbrxyz.com'
            vim.g.mediawiki_editor_path = '/w/'
            vim.g.mediawiki_editor_username = 'Cameron Brown'
            vim.g.mediawiki_editor_password = os.getenv("WIKI_PASSWORD")
        end,
   }
}
