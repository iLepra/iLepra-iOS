/*global module:false*/
module.exports = function(grunt) {

// Project configuration.
    grunt.initConfig({
        concat: {
            logic: {
                src: [
                    'www/js/templates.js',
                    'www/js/prepare.js',
                    'www/js/main.js', 
                    'www/js/counters.js', 
                    'www/js/handlers.js',
                    'www/js/mystuff.js', 
                    'www/js/inbox.js', 
                    'www/js/posts.js', 
                    'www/js/comments.js',
                    'www/js/more.js', 
                    'www/js/favs.js', 
                    'www/js/profile.js', 
                    'www/js/subs.js', 
                    'www/js/gov.js', 
                    'www/js/chat.js'],
                dest: 'www/js/logic.concat.js'
            }
        },
        min: {
            logic: {
                src: ['www/js/logic.concat.js'],
                dest: 'www/js/logic.min.js'
            }
        }
    });

// Default task.
    grunt.registerTask('default', 'concat min');

};